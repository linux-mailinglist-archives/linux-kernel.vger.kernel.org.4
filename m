Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B984F63F7CC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 19:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbiLAS7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 13:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiLAS7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 13:59:17 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CE4C23EF;
        Thu,  1 Dec 2022 10:59:15 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 98BF06C15FB;
        Thu,  1 Dec 2022 18:59:13 +0000 (UTC)
Received: from pdx1-sub0-mail-a235.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 0E9C86C1C22;
        Thu,  1 Dec 2022 18:59:13 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1669921153; a=rsa-sha256;
        cv=none;
        b=RMh4+wR/AygHwKwWdX+khRPsV0fBkCVmZkd2iSJdDWVdkjaopfCm8qssxHawdMqsa/SS2O
        F1cLhJ2TE8e5phJsJMCC20bNM9s4WlwfsC5xnf7uDG7YMuQM/DGL9Z+ZehNcAHV1d53imT
        fJotF/6D0lPTSwfTF1Febrv9pdrabGsF4zXUbg1ZTTQHyStfWUansAk21cJRitfEYwg117
        XEGEn5kcTJDT5kU0D29bXpAzMVCdm2Wk7C+mRirCb870O3M7dgfj4+GLN1S9lVQOMtbVWX
        ZsDAGrDteg4cvULQLJzmiaWMO55uscg5Dl8Wcvkg1J/QHLShrFe1MpG3YZz4fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1669921153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=z7oeIUm6HOp58r2npBD4sexb2oY259c988xemJq+4mY=;
        b=08kQ22x/h1cn1BGNWfLIbcSzcsM0lPvKH3JnrbAQyWJlFgtcILCDmkTQMkSQ93s/RziCkE
        43iHayr5HgDkS2jpPG4Sds32kJ6uJ6fNvT7DIppKaUrpYLtLz/KIHnwUzLiro0Qch9Nljw
        hyduxXDAC9OHjDF0iHolQceqyopdwZngeCDawTUXopVjclfG6Wc7FQixwXINXUzs/6PYFq
        jG4ZsIoKGrDR9H/OcTSKwMEH6i+mdp2/QVkK7Sf/vZeUhTIxnUYJonh+6hOxFwdvuK4N5I
        hpPMuBkEr4jd3fIuR9C4ZA4yNU4YDi/Wf7tWJau/c5NjkEaZVaItEjC4ngV7UQ==
ARC-Authentication-Results: i=1;
        rspamd-7bd68c5946-dtxhm;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Stupid-Attack: 66365b09702d4a8f_1669921153413_46851904
X-MC-Loop-Signature: 1669921153413:777858334
X-MC-Ingress-Time: 1669921153413
Received: from pdx1-sub0-mail-a235.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.107.134.116 (trex/6.7.1);
        Thu, 01 Dec 2022 18:59:13 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a235.dreamhost.com (Postfix) with ESMTPSA id 4NNQNH6whzz4C;
        Thu,  1 Dec 2022 10:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1669921152;
        bh=z7oeIUm6HOp58r2npBD4sexb2oY259c988xemJq+4mY=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=itFLihDO8FO0QnD9YkuN4nhcVgg6B/UQcHQF6ZhpUFXSK0uXmIytlmrH4I+DlN1wG
         F5zA3TCswwwjJGLz5GnNy97jTF+ddm086FhzxX1UClOsA0RSOgKNGnQOl8Uf1ZO8Im
         Aa+MNlgnBfpIh4TLNSKpiUKEhkKwISEpLOBG18WSe2Uu89/fEjsAXe2xrIS8NJHPgQ
         ajnJFEBoj+PO58qdL0024sCkKAi7X179V2DSowlgcW7xP81i9HhHB0jX4kgohxfJ0K
         zYBTWOeFaX8755RwRxCFDJjzyDbycZoLyQqNBBsa8T47VGNIOx8LRjBuXnUeBYTM+3
         dgM+KapGQ33qg==
Date:   Thu, 1 Dec 2022 10:35:28 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     ira.weiny@intel.com
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH V2 08/11] cxl/mem: Wire up event interrupts
Message-ID: <20221201183528.wwcgv35j2fxsncj2@offworld>
References: <20221201002719.2596558-1-ira.weiny@intel.com>
 <20221201002719.2596558-9-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20221201002719.2596558-9-ira.weiny@intel.com>
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

On Wed, 30 Nov 2022, ira.weiny@intel.com wrote:

>From: Ira Weiny <ira.weiny@intel.com>
>
>CXL device events are signaled via interrupts.  Each event log may have
>a different interrupt message number.  These message numbers are
>reported in the Get Event Interrupt Policy mailbox command.
>
>Add interrupt support for event logs.  Interrupts are allocated as
>shared interrupts.  Therefore, all or some event logs can share the same
>message number.
>
>Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
