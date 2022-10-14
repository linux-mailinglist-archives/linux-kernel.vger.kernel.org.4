Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5205FF296
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 18:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbiJNQxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 12:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiJNQwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 12:52:55 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CAD1C69CE;
        Fri, 14 Oct 2022 09:52:52 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 5DC88640DE0;
        Fri, 14 Oct 2022 16:52:51 +0000 (UTC)
Received: from pdx1-sub0-mail-a285 (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id B3CF9640CF1;
        Fri, 14 Oct 2022 16:52:50 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1665766370; a=rsa-sha256;
        cv=none;
        b=Ph4KsOifQ7SYQHDdvIbChczNcag8o59StORM18dA9Qs3TqQfrodtH0IDxZH7uCc6Z441hs
        7rxYLGfNRMBPPr4cL7x6Sj1K4ypa+sg7Ad6v+VoqVh669J+43P3mQXVqr5TK5AvUCT+k2p
        tP5F/LRbrEhSSGWC4lAiKGJhkE8ohA4kjSg+h7SqTX5QICa8D2EM9rjJH+Q3pRSpXeWUAE
        lSECKXiKDQ2LJwo85B/TglJkYmNJ75kWx8hC1gzxzKsohGTlxBh6fzpPk2rKwUSMjS/E68
        HwFYU9qOf7SK4UCheMagGVlBKejk4EiYz8RNMBOXnm25sg4te33En4v2YR15gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1665766370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=VXv+P71c4vzTRrfPraL5ddMtH2hCJErWbUesX0qQy3k=;
        b=rbwN21pry0LZKmanvsCL17eM11Ej4pFRfIyfyE6nNg8rMcPaWLIJPvkqbtRYyQbfY2qewU
        hQ4+qczYRkb8PPTVAelEA/SNO4fXhI3/6gyEhxZCGrS4rXy8LkGG4H06Yk67aK9R4Ydzvi
        jdzxuPTAr2mXKgprCGiOAfKFrSVIhWQW/NKHt2pI1IhLauyMQtjHwlAS59Mi6mrfzHU7UW
        Ayt3mu/7R4qCW8gVI8dkeYkNqlJMo6z8VFkrpjpzIKfOn8tTLrcOfGow++dmf5hca6UswB
        5SW0TVK1ErBe0nnJptZdB1bYsw9VNfY0jga4jmTtwCROu9f9ltJSQ0LhiJNmuA==
ARC-Authentication-Results: i=1;
        rspamd-5798657bcf-xqzdk;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Spot-Whistle: 5ccf444e1e30d890_1665766371169_77002921
X-MC-Loop-Signature: 1665766371169:3588203213
X-MC-Ingress-Time: 1665766371169
Received: from pdx1-sub0-mail-a285 (pop.dreamhost.com [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.97.34.85 (trex/6.7.1);
        Fri, 14 Oct 2022 16:52:51 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a285 (Postfix) with ESMTPSA id 4Mpsrb5XTMz1v;
        Fri, 14 Oct 2022 09:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1665766370;
        bh=VXv+P71c4vzTRrfPraL5ddMtH2hCJErWbUesX0qQy3k=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=jqw1Ig0RQKHI6fW3PZ+Gic0mh9QeXiprzu5f4wP5ohFMnziQXOMPrPV4NyUBQRWxB
         RTjNaOtZfAuQs1aaB9/KzBcA4vjwzXso0P08rTr9OgsHeAckkZkrXFruPQgWCETzaI
         r49zPO0OnzzNVlG7qD/Bv90Bw26AoJ40OJr7QhJXlYz1AMjXFju95Sz8fwJq15v4cQ
         YAaTnZkwzZz9effYu7Qt71HFam+y1zwmHzqTCj3p3gH3mP5joZEzhKJ/z+Mdu0lZLo
         qjKkZVlCzsGccCG6w0ZW5PzpoM2lz8o1tg6JJ4Ja+umltQx+aKbBPMOyK6BLfkZWtk
         tDZTXeIdR8LXg==
Date:   Fri, 14 Oct 2022 09:31:49 -0700
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
Message-ID: <20221014163149.6zwx6nrbzfbc5pps@offworld>
References: <20221010224131.1866246-1-ira.weiny@intel.com>
 <20221010224131.1866246-2-ira.weiny@intel.com>
 <20221014162921.oth2ing7gv3ofuha@offworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20221014162921.oth2ing7gv3ofuha@offworld>
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

On Fri, 14 Oct 2022, Davidlohr Bueso wrote:
>>-	if (mbox_cmd.return_code != CXL_MBOX_CMD_RC_SUCCESS)
>>+	if (mbox_cmd.return_code != CXL_MBOX_CMD_RC_SUCCESS) {
>>+		dev_dbg(cxlds->dev, "MB error : %s\n",
>
>Maybe s/MB/mbox?

Actually 'Mailbox' seems to be the standard:

core/regs.c:			dev_dbg(dev, "found Mailbox capability (0x%x)\n", offset);
core/regs.c:			dev_dbg(dev, "found Secondary Mailbox capability (0x%x)\n", offset);
pci.c:		dev_dbg(dev, "Mailbox operation had an error\n");
pci.c:		dev_err(cxlds->dev, "Mailbox is too small (%zub)",
pci.c:	dev_dbg(cxlds->dev, "Mailbox payload sized %zu",
