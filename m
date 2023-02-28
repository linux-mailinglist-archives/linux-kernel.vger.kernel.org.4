Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF706A6286
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 23:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjB1Wet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 17:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjB1Wes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 17:34:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CAD367C0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 14:34:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C265B80E4D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 22:34:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8715CC433D2;
        Tue, 28 Feb 2023 22:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677623650;
        bh=YinmanrDphP7CYw6RU6G56QD3buUexPR5spDlNZcpSs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FZw4vR0ubEvDXEjwSdYeB1c9RhPrdRxrIl4+qLezs2XdiOHYTzAoPDF3kXG7PLlT+
         nPV2dzXKri1rImcxGh3ACfbQFPKXssyGPCENZQDJ1F4R5cSHYIXiphcs1g1bLqvJ7P
         ZmBsYeffig+uLgnkyTmYIeeQAZm5bSsVBpZj4LnJ3Ph0y32zqHaoDDqfXTKEambywk
         V34YFQqYhJB74zsBH7lg2oSgMGf/AdrHWBZXuGqsc61oOlJiolkqBLxXY3QvmDkWeh
         wbuaTFGbkCzUE4rTuH7TExa/QY/0wI+B8El0eenQPKkGT/NTSKR5SXohCDQ5SzEuZg
         LvBN3VJbykpWw==
Date:   Tue, 28 Feb 2023 15:34:07 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, elvis.angelaccio@kde.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: Add a module parameter for users to force simple
 suspend
Message-ID: <Y/6BX58qVUUx/Ey2@kbusch-mbp.dhcp.thefacebook.com>
References: <20230228221148.2672-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230228221148.2672-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 04:11:48PM -0600, Mario Limonciello wrote:
> +static bool nvme_use_simple_suspend(struct pci_dev *pdev)
> +{
> +	if (!simple_suspend)
> +		return false;
> +	if (simple_suspend == 1)
> +		return true;
> +	return !noacpi && acpi_storage_d3(&pdev->dev);
> +}
> +
>  static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	int node, result = -ENOMEM;
> @@ -3128,11 +3145,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  
>  	quirks |= check_vendor_combination_bug(pdev);
>  
> -	if (!noacpi && acpi_storage_d3(&pdev->dev)) {
> -		/*
> -		 * Some systems use a bios work around to ask for D3 on
> -		 * platforms that support kernel managed suspend.
> -		 */
> +	if (nvme_use_simple_suspend(pdev)) {
>  		dev_info(&pdev->dev,
>  			 "platform quirk: setting simple suspend\n");
>  		quirks |= NVME_QUIRK_SIMPLE_SUSPEND;

Do you want the user setting "never" to override the driver's default quirks?
