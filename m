Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D800738C2C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjFUQrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjFUQq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:46:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15C710CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 09:46:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 773E5615D9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 16:46:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F34DC433CB;
        Wed, 21 Jun 2023 16:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687365979;
        bh=u5z3ftv6BB076pT5euIJojw2xnPqDLGdMYKakdyytIY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hj63S+ykIPE+j7FWCIXD97o63nTf17Gp0jFj++wXidUxhZ67umI9k+oGfZZpXlIJZ
         QnHEYWbweXL2c1RcZ3ZRcB8b1RZw7ZkpPnWC0jr4DE4sYbYBDLYvgzI7lOp0qeQn25
         9ZKRVIc56nsK7zOV2MRJEgYtLYwMrDQ0XiLbxVSPkixx1jp0lxtlEN31CzV3LTJczn
         IH5r6t4oAhwVLmAbdOKKKhZGXgogIHDdoO0wxEvauQdI4KMw6TpoTyrfgKGgvBaGjt
         Qf2Sdoeywzmk/rW7W2Rym5MMTuLE0cCucvxcTl6TH0ha6BgbjCbIL54MianYuXT/Nr
         VMUNaPFRkuykA==
Date:   Wed, 21 Jun 2023 10:46:17 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Breno Leitao <leitao@debian.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, leit@fb.com,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] nvme: Print capabilities changes just once
Message-ID: <ZJMpWaMxKMFE8hmK@kbusch-mbp.dhcp.thefacebook.com>
References: <20230615094903.1341683-1-leitao@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615094903.1341683-1-leitao@debian.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 02:49:03AM -0700, Breno Leitao wrote:
>  	if (effects & NVME_CMD_EFFECTS_CCC) {
> -		dev_info(ctrl->device,
> +		if (!test_and_set_bit(NVME_CTRL_DIRTY_CAPABILITY,
> +				      &ctrl->flags)) {
> +			dev_info(ctrl->device,
>  "controller capabilities changed, reset may be required to take effect.\n");
> +		}
>  	}

Thanks, patch applied to nvme-6.5.

A question for Christoph and future consideration: I *think* the
complications that had the driver stop refreshing the controller
attributes are largely mitigated by the fact we now handle effects
after the request is freed. Perhaps I'm missing something. Is there
a risk in just bringing that feature back into the driver?
