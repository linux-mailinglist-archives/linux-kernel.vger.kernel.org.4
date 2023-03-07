Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBE86AD595
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 04:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjCGDRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 22:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjCGDRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 22:17:04 -0500
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306567EEF;
        Mon,  6 Mar 2023 19:16:27 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id BC4A85C0A4E;
        Tue,  7 Mar 2023 03:06:00 +0000 (UTC)
Received: from pdx1-sub0-mail-a206.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 236AE5C1317;
        Tue,  7 Mar 2023 03:06:00 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1678158360; a=rsa-sha256;
        cv=none;
        b=cHtdUigyZivh467zszhrhBVCutRs6EHRiOLzX1t0wtfG7Q43y6VGpD9571wR1lNwwr/ilT
        aNKjhINpN/fZJ6PpueVmZVvb7QAXkSqjuoGJMKnqedk2cJturCVEGmp4cFfiTP6pgarAAk
        6+Wg40dEFNAucsB0epz/NZR3b+m0yHykr+q1soqmemi2xNhgLGyO9IL5I4yhDP72kFtBwK
        e+b12hrA9/7ROKJOhwqAytbidDEQCV/F+xaNt3yXfakO+6cgnMc6jJBgsmycUxt01UC3RD
        Sv+tnC15dViRwhlgZy6v78dK/S3MzK4StWi32NwVzsDGKf9aSoHajSCzx6p3KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1678158360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=cS8qyos2zZngD0Sbb383Sp/fAKIfbdQf6NRl8D5NnPQ=;
        b=udZI3bFOlRXLTw7wJTNjsIVFznWSgU7j7LE2BaAv/4KtrtUnEJLdk3qfljdplacn/braaS
        pB17B9r8GnZvuEpzmz/ZkYZ9e93FjrdWDKcu6ecvX2gj7OqS6tWO2Vxs+LWDyij9DaeFar
        o/Kn4eFCzf6ongESFzVLrBPFqnqALaNHOwlNsFCCUP9w2eZV/gQx5iO3rzXqy7QqsYLg6U
        T3dFJl+MgWb+XGMwbX7NzcXnkxOXM8C81ycQhoHJrvxxAJP1bAjnABSZNFJ49GUONAw8sP
        IY3oJyswXLznUI7BBNOipA7dEfbzKnvALBc3OyN6hj/ppnRjeObZtOpTEj92Fg==
ARC-Authentication-Results: i=1;
        rspamd-69778c65cd-ktdqp;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Callous-Whispering: 6e365262054f08b4_1678158360567_4098767612
X-MC-Loop-Signature: 1678158360567:3780146233
X-MC-Ingress-Time: 1678158360567
Received: from pdx1-sub0-mail-a206.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.109.196.245 (trex/6.7.2);
        Tue, 07 Mar 2023 03:06:00 +0000
Received: from offworld (unknown [104.36.30.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a206.dreamhost.com (Postfix) with ESMTPSA id 4PW0h66Jncz94;
        Mon,  6 Mar 2023 19:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1678158359;
        bh=cS8qyos2zZngD0Sbb383Sp/fAKIfbdQf6NRl8D5NnPQ=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=Xq2gvgRSt/ZzYQ9Hfc2Kzd8Ji5mvy9tuMPDu+544w67QAsy49TqXCCxKTitj1QhU6
         zRDa9NEP9sUEHyLgNMoVctElEabkN+wzP52d5AunJKnFIeH0bT1Z7VMl2l6lFI9afS
         rJT/BpMEXnUv0hhsJgkImzvGzyihR7hMFw9m+d+60NB+yUSWIh6qYE3dYp9xoArTA9
         FXjho9quBYutWFtS0jIC/ZMmq3uqKY6Zml0XmBmRNDAd8fn64TUnwQDWuUWSFSaqTG
         zXHJxppO89wfu040fvT37vuyFq8VJkQt6AsYaGHoNAHK/jZn9ES8Ze3Q9Iee/Di05k
         jkoQB2pke4gxQ==
Date:   Mon, 6 Mar 2023 18:36:56 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com, will@kernel.org,
        dan.j.williams@intel.com, bwidawsk@kernel.org, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        linuxarm@huawei.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] cxl/pci: Find and register CXL PMU devices
Message-ID: <20230307023656.cyntxctzqgpam5u3@offworld>
References: <20230303175022.10806-1-Jonathan.Cameron@huawei.com>
 <20230303175022.10806-3-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230303175022.10806-3-Jonathan.Cameron@huawei.com>
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

On Fri, 03 Mar 2023, Jonathan Cameron wrote:

>+int devm_cxl_cpmu_add(struct device *parent, struct cxl_cpmu_regs *regs, int index)
>+{
>+	struct cxl_cpmu *cpmu;
>+	struct device *dev;
>+	int rc;
>+
>+	cpmu = kzalloc(sizeof(*cpmu), GFP_KERNEL);
>+	if (!cpmu)
>+		return -ENOMEM;
>+
>+	cpmu->base = regs->cpmu;
>+	dev = &cpmu->dev;
>+	device_initialize(dev);
>+	device_set_pm_not_required(dev);
>+	dev->parent = parent;
>+	dev->bus = &cxl_bus_type;
>+	dev->type = &cxl_cpmu_type;
>+	rc = ida_alloc(&cpmu_ida, GFP_KERNEL);
>+	if (rc < 0)
>+		goto err;

Probably better to do the ida_alloc after the cpmu allocation above, before
arming the dev.
