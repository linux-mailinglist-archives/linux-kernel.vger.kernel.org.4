Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F205FF28E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 18:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbiJNQup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 12:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbiJNQu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 12:50:28 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47285537ED;
        Fri, 14 Oct 2022 09:50:23 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 9F6625C0E4B;
        Fri, 14 Oct 2022 16:50:22 +0000 (UTC)
Received: from pdx1-sub0-mail-a285 (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 07A9B5C0E06;
        Fri, 14 Oct 2022 16:50:22 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1665766222; a=rsa-sha256;
        cv=none;
        b=PVW9OxlRPuTwCht5xX5h+FflhnC3F1pGoDLNdclXjq1n3z4EiXiE/EgeHSai79mvqUNqZk
        +9o0mI5gMaW3TY0HDMbF1w0tA0LJbePlXK51DLbFjbk8pzZXduy3lvY+8afu8Rj+L+/L3T
        9i81zGuREZuE8wRZul3kjGGih28HKA/YqWLG5mINoeo7wsL7CJ1UCo6wLZYFvTeofjkB+f
        LfAeByhJZ4G1Dzl0pxTYXXmH615APTLndyXZ6btlikNYWd9CauLTzZsatumrR8YSsmUZpv
        IpQA/V/KX6nkSnP/T7IJUwr4qErh6XVWvFqymzKCY+VD+/pVRXOBqdzqihA2Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1665766222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=StdcPcuJph/ZOvrjwwJyCvorBVN1vMRUf4MuKvd8X4E=;
        b=Gcpplx/9pTU31T4hGs1zLKdX+AuWCSVkfdG2PdsPkOEoaB5ecRQI4CWTYF94nlyZCaq6+r
        mwWamWaDLSp9/1bIkSDVfNBPXrW/UY63BrcQtGqt0X9Nk/qTmUdrC2+I3nvxaFvSsG1fCo
        k6Ih1oYXJv4PBl4QXayc0dgNV2InFTmcLBURCVEu0JtOirsL6EWUc/7/a+Dof0zYghpI1b
        vCGDK444huTc7+OhhcLXYvD79o+aAj8WoEy484QGkKchDytjET0h6Mkx1JaV3lclu+IwLE
        t3pY/LJT4Rvpeqih1lKFLl1N/xQw/gHyu9d0m85urffIkn9NQ6P57YFrkphmiA==
ARC-Authentication-Results: i=1;
        rspamd-5798657bcf-rqdj4;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Exultant-Gusty: 7745908f3c8b3220_1665766222440_2225553681
X-MC-Loop-Signature: 1665766222440:394936268
X-MC-Ingress-Time: 1665766222439
Received: from pdx1-sub0-mail-a285 (pop.dreamhost.com [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.122.72.77 (trex/6.7.1);
        Fri, 14 Oct 2022 16:50:22 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a285 (Postfix) with ESMTPSA id 4Mpsnm2NfLz61;
        Fri, 14 Oct 2022 09:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1665766221;
        bh=StdcPcuJph/ZOvrjwwJyCvorBVN1vMRUf4MuKvd8X4E=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=oCT94T0zKkYkORrafjcKG0tXKF4PUteneNeYhHfEOteeCoUVordFBV9jokXuIU3tk
         mmHi8EP4TpUTdcops7LsdX9LwtZ6ldwHjPUtL4vGtibhvMTM1hosbYhob2Z3Y3QAJh
         2Lpw1vMacAwVwMXUYLTSO5fPqgFeCEQkOrSlZnV3WxK6XOnGRdVk2qPQVdtxsEqEJx
         7+fzqp0pdk77GX6aCpzP1kx6FO37h3W3DIHDSa2RGlX3AdGgdMTjwYUzh3emF4KRvw
         rORT7nszmioXsnvINYiSy6TgxBxodOTiMJWXHdE6/tTOajKeGqS7q5hfiHJbCuW81Y
         HL6G2T8dN2QkQ==
Date:   Fri, 14 Oct 2022 09:29:21 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     ira.weiny@intel.com
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [RFC V2 PATCH 01/11] cxl/mbox: Add debug of hardware error code
Message-ID: <20221014162921.oth2ing7gv3ofuha@offworld>
References: <20221010224131.1866246-1-ira.weiny@intel.com>
 <20221010224131.1866246-2-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20221010224131.1866246-2-ira.weiny@intel.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Oct 2022, ira.weiny@intel.com wrote:

>From: Ira Weiny <ira.weiny@intel.com>
>
>If a mailbox command fails the driver always reports ENXIO.  But this
>may not be enough information to understand why the hardware, or in my
>case Qemu, was failing.
>
>Add a debug print of the error code returned from the hardware.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

with a nit below.

>
>Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>---
> drivers/cxl/core/mbox.c | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>index 16176b9278b4..6c4d024ad0e8 100644
>--- a/drivers/cxl/core/mbox.c
>+++ b/drivers/cxl/core/mbox.c
>@@ -181,8 +181,11 @@ int cxl_mbox_send_cmd(struct cxl_dev_state *cxlds, u16 opcode, void *in,
>	if (rc)
>		return rc;
>
>-	if (mbox_cmd.return_code != CXL_MBOX_CMD_RC_SUCCESS)
>+	if (mbox_cmd.return_code != CXL_MBOX_CMD_RC_SUCCESS) {
>+		dev_dbg(cxlds->dev, "MB error : %s\n",

Maybe s/MB/mbox?

>+			cxl_mbox_cmd_rc2str(&mbox_cmd));
>		return cxl_mbox_cmd_rc2errno(&mbox_cmd);
>+	}
>
>	/*
>	 * Variable sized commands can't be validated and so it's up to the
>--
>2.37.2
>
