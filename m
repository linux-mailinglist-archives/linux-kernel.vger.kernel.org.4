Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0ADC606B47
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 00:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiJTWbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 18:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJTWbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 18:31:32 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B931316DC3A;
        Thu, 20 Oct 2022 15:31:30 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id B9DFF411F4;
        Thu, 20 Oct 2022 22:31:29 +0000 (UTC)
Received: from pdx1-sub0-mail-a280.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 291354148F;
        Thu, 20 Oct 2022 22:31:29 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1666305089; a=rsa-sha256;
        cv=none;
        b=5rMRsuDHcJfvh/LZx+tIr2jMlE8cbUL85NxxrryJ/xm2llSRqXaU3nNqYzfKuhnoyJOA+l
        8kEOeI3+5ZzUf1r29/JPIclHsaBqAJVDmg3E+/cQbjxSZFuI4FIMk498qDOVZJOOV00Y15
        zpSqlLScgxne1EEPYh9vXw+2knZXux0uyP+wC5+JTnGZU26vsaUauYUADAqg4OBWGINnYu
        7Sd8TdyMDrqF9en0qwMm4XpHtTqRgSry3/+kZoB5ze/dhNERPa59sBMNRgz1fNTGUIfe/H
        nRtEws1mVAaZg/xuPV2F55lA/iuxXeW98VSW0O5GOoC/Kz/sWs4kiNgSnO3ZGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1666305089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=FiZrMkrbNubHQO8sAmPoXSgTBVbDs1cimp79mld8fpA=;
        b=wZmErFDsVUFUy/Jh2ZQuh4BFywNduP1aba9E4F85nS3F9hO0fPF88M41gXQRLoJShoZSfm
        pb6mkwXAB3qkaO0C9rNSYnMbEN3yM8E6vFRk3OIs4T71CPeW8Fphy76mYIGQhxRSd7029X
        8oFHMcQsNHvi0AsyZHVEvRsJFqsq/NF1EcqbhTZFgPPqGW1MHUG6VJQcYNlpkq+T5GQaBY
        VFNstsG6Y4/DcMWhek+scAhfQDUeiDzWGrZcNe1axzEa5JZm4xl5rSk8RR8aLOq4dcPHlf
        rW6tnNUxyNLRyXXyck0hRQEL4aOGcV0ihuXaGUYqyNq186Jg09Jfkya+p7EhfQ==
ARC-Authentication-Results: i=1;
        rspamd-6955c7cd5b-xbdk9;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Soft-Plucky: 6601109c31f79505_1666305089527_1996093706
X-MC-Loop-Signature: 1666305089527:846727707
X-MC-Ingress-Time: 1666305089527
Received: from pdx1-sub0-mail-a280.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.126.129.222 (trex/6.7.1);
        Thu, 20 Oct 2022 22:31:29 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a280.dreamhost.com (Postfix) with ESMTPSA id 4Mtj4c2HL0z5h;
        Thu, 20 Oct 2022 15:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1666305088;
        bh=FiZrMkrbNubHQO8sAmPoXSgTBVbDs1cimp79mld8fpA=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=lFUWZ1HJ7mmYeXIfNiicNJE0dqTPoTi2U4KK0rnhhmzHnnhyujr2zjjISe4Qh9y1E
         anJ/DuBCb8G8WfHRY/U2DYpscNQMSu2HoreF3ypP2ICRL407+JFZWL7PIoAZks6uYT
         sijaNFmupE/KaIlbkK7Y3Bp0/4Q7tcDP4giwELxs1GaUP5hYdsnj5dUZW74tIH2cId
         +Gy08RBSU/HzhaSfgLbBt9BTy4VvX2Z/Ib3WaCXJszqywGe/pHjjtVJHdlW7GmtTx/
         a89+yMYhEcb0IEsneQISmRtI8BqhFsx/CDW/hS9smUxHB80pwY3BqkrEQs2hN5dNNy
         muNhtGg5ceHYg==
Date:   Thu, 20 Oct 2022 15:31:25 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        dave.jiang@intel.com, alison.schofield@intel.com,
        bwidawsk@kernel.org, vishal.l.verma@intel.com,
        a.manzanares@samsung.com, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cxl/pci: Add generic MSI-X/MSI irq support
Message-ID: <20221020223125.hyrfpt2noiicisxa@offworld>
References: <20221018030010.20913-1-dave@stgolabs.net>
 <20221018030010.20913-2-dave@stgolabs.net>
 <20221018103619.00004c39@huawei.com>
 <20221018115227.00002a4c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20221018115227.00002a4c@huawei.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Oct 2022, Jonathan Cameron wrote:

>Reality is that it is cleaner to more or less ignore the infrastructure
>proposed in this patch.
>
>1. Query how many CPMU devices there are. Whilst there stash the maximim
>   cpmu vector number in the cxlds.
>2. Run a stub in this infrastructure that does max(irq, cxlds->irq_num);
>3. Carry on as before.
>
>Thus destroying the point of this infrastructure for that usecase at least
>and leaving an extra bit of state in the cxl_dev_state that is just
>to squirt a value into the callback...

If it doesn't fit, then it doesn't fit.

However, while I was expecting pass one to be in the callback, I wasn't
expecting that both pass 1 and 2 shared the cpmu_regs_array. If the array
could be reconstructed during pass 2, then it would fit a bit better;
albeit the extra allocation, cycles etc., but this is probing phase, so
overhead isn't that important (and cpmu_count isn't big enough to matter).

But if we're going to go with a free-for-all approach, can we establish
who goes for the initial pci_alloc_irq_vectors()? I think perhaps mbox
since it's the most straightforward and with least requirements, I'm
also unsure of the status yet to merge events and pmu, but regardless
they are still larger patchsets. If folks agree I can send a new mbox-only
patch.

Thanks,
Davidlohr
