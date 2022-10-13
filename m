Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9E65FE28F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 21:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiJMTRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 15:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiJMTRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 15:17:44 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F3D42D60;
        Thu, 13 Oct 2022 12:17:42 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id DD1D58C0EB1;
        Thu, 13 Oct 2022 19:17:41 +0000 (UTC)
Received: from pdx1-sub0-mail-a227 (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 6707E8C0ED2;
        Thu, 13 Oct 2022 19:17:41 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1665688661; a=rsa-sha256;
        cv=none;
        b=ev0Pa9JMgekliEN7jdWnJqydhqe8XrgaRKIiTJS8oJprPThRt/m9lrXNOjaR/PNylGZJq5
        emMUBXYk5d7FEcAtAwUnpCN+SvzNFcJMEQZXmnZWYfGEAYRSO7/wPcS7mYiSmwlNyJWZtk
        x4k8ws8QAJhHzBjCgTETEqyCvj8vA2EBOX9GrvF+bmaSoxmtYnIj+J9dUexQoaAzf/xSY9
        Y9UYMZKJhcPYlaVKkeTysr33PfzKfuZcz1FzJYjVeKmAshK77Qp/nrvEXwVJm72u+AGHR1
        pZbw2JvLueSurm2pYyBGffOsvlI1SzwqF16qkYLVttT3VySSgiap/uyPrKXUMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1665688661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=WfiTZBhn2D40RpfvkE1jyCdsO1XGICdV9UctgBt+III=;
        b=yUliAF/qmqUuUg4dyAY58nuX/w8B7nj0l2Zfftw7fKS+S8HLv8g1K4I7yb+GiWE5eoN5sN
        PbexA5FCvYJCyqpBrJwpFWAT1Pl1pf+1BqGptbsAyWB+91+gaUDo02WQ2kXULTlhwXA6p2
        OZdXe2rHHWvv+VPiImKcJnuqPAHjfqJODJdYb04irCr2lsXNvIOq7GYNNGHrK6Jxw5Z0nY
        CkJNZ4NACsjDQf/Bv5j9Q2L9vbUSrgIc4MXHtjuGhcLhoEmVNpxbPaZmM5LL9mn2M8Qi0L
        rTfO41wUbzn9ko/N1h8v056tSdftocOCYiboQXUlyacWroVjuKA7wTK5jZmefA==
ARC-Authentication-Results: i=1;
        rspamd-7c485dd8cf-57msx;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Rock-Illegal: 117e215a45c686da_1665688661663_587694324
X-MC-Loop-Signature: 1665688661663:1857888615
X-MC-Ingress-Time: 1665688661663
Received: from pdx1-sub0-mail-a227 (pop.dreamhost.com [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.119.144.148 (trex/6.7.1);
        Thu, 13 Oct 2022 19:17:41 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a227 (Postfix) with ESMTPSA id 4MpK6D2k4Nz8T;
        Thu, 13 Oct 2022 12:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1665688661;
        bh=WfiTZBhn2D40RpfvkE1jyCdsO1XGICdV9UctgBt+III=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=RThk3Xt2HHFt/SjCqCtq6LkkpDUCR+KMPfK92d2NXqZxOd71OAzEKKYrTpolwJyc/
         ztNm1i3drBOAfdjJe5PHBTJcqZYXuk5kl6w5BKprijjw8vGFb+795IjXx4RhdN/dhA
         tZn79BNe6RgXTe+46uAu0z9ox/Qoqf4pgJXqOfmQ585S8y7unIaIvm9DZBk8BrEs/c
         8z8W866EPJVRCEmel1saY0k6cRFga+3uaI6vXUjH+kDNXsl2JFPJaHnlwY7UP51XsG
         XXfoGGIQtkHGpt3IhqXOt2OC5+fL3pEqZ+8vmCkGznAogUXCQ39DDFWoRfZuVaTKJZ
         Qudox33ASHlXw==
Date:   Thu, 13 Oct 2022 11:56:45 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        alison.schofield@intel.com, vishal.l.verma@intel.com,
        bwidawsk@kernel.org, a.manzanares@samsung.com,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl: Add generic MSI/MSI-X interrupt support
Message-ID: <20221013185645.p5rg6d7mhpnpze3h@offworld>
References: <20221012180432.473373-1-dave@stgolabs.net>
 <20221013131913.0000038b@huawei.com>
 <20221013173703.th54drzlafvj74oo@offworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20221013173703.th54drzlafvj74oo@offworld>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_BL_SPAMCOP_NET,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Oct 2022, Davidlohr Bueso wrote:

>if (cxl_pci_alloc_irq_vectors(cxlds) > 0) {

bleh this should be == 0 of course.

>   cxl_setup_mbox_irq();
>   cxl_setup_events_irq();
>   cxl_setup_pmu_irq();
>}
