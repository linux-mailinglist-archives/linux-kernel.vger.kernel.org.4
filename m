Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4CB5FCA2A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 20:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiJLSBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 14:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJLSBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 14:01:48 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BC1FBCF6;
        Wed, 12 Oct 2022 11:01:43 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 3CAFF5C0D08;
        Wed, 12 Oct 2022 18:01:41 +0000 (UTC)
Received: from pdx1-sub0-mail-a274.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 802BF5C0E3F;
        Wed, 12 Oct 2022 18:01:40 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1665597700; a=rsa-sha256;
        cv=none;
        b=0lst7vhA9KXl0BlodcmFdXLLZnM+x1RONigwbyhU8YAfOubeu4FyF7EFXcVs3B2HU5EIk7
        G63URJOktCMk82zgBGpvIk6oRHbXtWkrDGdDPlQMYVBsxmFji7rMBZ/T4XYteX21PR8I9J
        xYqi/wrX5NZvAvm/ioWYMHLMO8jqONyf2X8RgXD4qulxWyQKn5TCSugCFR/zkXB0YxebBw
        IwtZZc/MpEmlbzCg8aHvla+utDKFBf9J8thfYg/HcQL5MAJzDMceASdJZiiloY+39jhSFK
        ljisgF2iA2XitA5NBb2ZGwhDnlMC7g3gD/G6qjBjdVv3bCD6NNcYfqfasfGNPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1665597700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=Azo9u6vmwQjmSBLUFi8/jPp/M7Ky8iFJDRjtNAbVVcU=;
        b=N2iY9VJE9bgfsoS0d8LUQQ0OumugEGE8p3ovQ31isgCcfcs882Sd5J4mGvTR/Bw1kEb5Dl
        a4IIdZ+wT3I00iaQPbBUIKTje2ZsXb99B2rlMynnD7uwWzAhglYDZGTfZJylarKbs6IwpM
        bV47iU7JbBWCOt+avco15FVa8NvjxzuXjWxGBq3w7SWso3rSkvYIn7veF9eTmx8Sn6v5GB
        zTDXw5w/Z2gpWvSGVb+J6uPYufrpBU9giKktlrlC/uiDNW+RJzMI481AbA6CnlQVBUwOic
        HyZU1KzPSkLBKlwIl4nbROc3WJt1Zwl89Sa+Tqh/BQtvZg1psIa8Qf7jmsG/vA==
ARC-Authentication-Results: i=1;
        rspamd-7c485dd8cf-gbptx;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Shade-Occur: 1123a4d62971cc82_1665597700946_3907678197
X-MC-Loop-Signature: 1665597700946:1268412590
X-MC-Ingress-Time: 1665597700946
Received: from pdx1-sub0-mail-a274.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.126.129.213 (trex/6.7.1);
        Wed, 12 Oct 2022 18:01:40 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a274.dreamhost.com (Postfix) with ESMTPSA id 4MngSz4SgDz2l;
        Wed, 12 Oct 2022 11:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1665597700;
        bh=Azo9u6vmwQjmSBLUFi8/jPp/M7Ky8iFJDRjtNAbVVcU=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=fdlc1Hni/YpMgQn4bNby6ioIjqrq6tUchl1LgX/qM7tuvwy2qTsNF3erQkYrh5iD5
         NkYXWGbgK0saY4jqyAguyXEh58wUBH7CcIMwJbovKqQDxuuUlTmtVZi7wDCVJBRxSD
         2uttD+J8P8cSk3HgSAV4JWSrdRDkN56pRsxRMlXeompyVVMoXWIHe7Jptb1YbE4ho7
         mkFc9so21D/hdUKjneaEe4QoG9lExH2i4PxDuyQDSGeMzydddjT9cXnVTtT4OmkBsh
         SsweFUIvpwSx6EZpaRSrpAsfW4WDjXssBiiz6V3P8xPPZY6dbDdjNXlHVPJCQIrVWt
         DM+KOy60hxutQ==
Date:   Wed, 12 Oct 2022 11:01:36 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     ira.weiny@intel.com
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [RFC V2 PATCH 11/11] cxl/mem: Wire up event interrupts
Message-ID: <20221012180136.tc3ryjumquvnaqk2@offworld>
References: <20221010224131.1866246-1-ira.weiny@intel.com>
 <20221010224131.1866246-12-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20221010224131.1866246-12-ira.weiny@intel.com>
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
>CXL device events are signaled via interrupts.  Each event log may have
>a different interrupt message number.  These message numbers are
>reported in the Get Event Interrupt Policy mailbox command.
>
>Create an infrastructure to query the max vectors required for the CXL
>device.  Add event interrupt information that infrastructure.  Set up a
>handler for each event log.
>
>Davidlohr suggested the generic vector code.

So this should be a separate patch, and out of the event series altogether.
There are a number of interested parties for irq support, and imo the
generic vector stuff should be a first dependency to all of them.

I've sent out a patch with some updates you did. I also kept the whole
table populated with nil callbacks as I believe this documents the TODO
nicely.

Thanks,
Davidlohr
