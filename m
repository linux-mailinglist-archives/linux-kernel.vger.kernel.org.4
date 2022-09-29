Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB08E5EFB72
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 18:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236015AbiI2Q7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 12:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236043AbiI2Q7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 12:59:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DD91CFB81;
        Thu, 29 Sep 2022 09:59:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CBF35B82576;
        Thu, 29 Sep 2022 16:59:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCDC9C433C1;
        Thu, 29 Sep 2022 16:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664470752;
        bh=yBGZma+h0goCNzGQ3b6u10XnYurahn7ityyKftocg/k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KqtQN1dM354bqBa+U18wuRdBHHRwC13KtjP9RTmSpcgG+2WZ6uQMCLX957242HLgY
         bS70wuyICSSmQUXyBM+L7E8TbBxH9qbZJW5V5UlSiJgvF2XOHjf9KEz+cHZ/wM9Cbn
         s3JBc+Kdt4JJWQuejaH9h2XcP7d5pYzvPahdy5R4zjXCeSelaDrQprMIMhseaB6esu
         ex5O8FkXJFAUA6StUL8F8n6x3715UNbVvD5ijfBLcxWhV/OMsN0IeIFFHLIoftszYt
         VutPQ4ffc1wCKYNzbtBWr5stpv+GNQHZCKTM/Gs3a4NWjBvycClCafAdhgCDdgBy3l
         3PipGTRuaKATA==
Date:   Thu, 29 Sep 2022 11:59:08 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 09/14] mailbox: Add Gunyah message queue mailbox
Message-ID: <20220929165908.zgmlujhp42ihine5@builder.lan>
References: <20220928195633.2348848-1-quic_eberman@quicinc.com>
 <20220928195633.2348848-10-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928195633.2348848-10-quic_eberman@quicinc.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 12:56:28PM -0700, Elliot Berman wrote:
[..]
> diff --git a/drivers/mailbox/gunyah-msgq.c b/drivers/mailbox/gunyah-msgq.c
[..]
> +static int gh_msgq_send_data(struct mbox_chan *chan, void *data)
> +{
> +	struct gunyah_msgq *msgq = mbox_chan_to_msgq(chan);
> +	struct gunyah_msgq_tx_data *msgq_data = data;

The mailbox framework abstracts hardware mailboxes and @data
should be the data to be written to the hardware.

Using the void * to pass composite data types means that the client and
provider are tightly coupled and as such the mailbox framework does not
provide you any abstraction.

You also only expose a single channel, so a direct function call between
the two specific drivers would be a better fit.

Regards,
Bjorn
