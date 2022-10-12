Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC9A5FCEF9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 01:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiJLXg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 19:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiJLXgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 19:36:54 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959D8FF20C;
        Wed, 12 Oct 2022 16:36:53 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id DAC4754189B;
        Wed, 12 Oct 2022 23:36:52 +0000 (UTC)
Received: from pdx1-sub0-mail-a209.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 597B9540B50;
        Wed, 12 Oct 2022 23:36:52 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1665617812; a=rsa-sha256;
        cv=none;
        b=jcGZdZPq2nwQIGD2dPYME/Up7ESkeMqRGQbXTxCHRbtiIYjxj2LY48F4MYSBLcwi7DDHuB
        NODxBKFBxsnRHGsI/4dYleAPK6Dkz+QDjo/lnMhXfSsP87OedmuKawp7iMXdqagRdPAx2Y
        zOKxuXkm4DRfLWY4EB0/Yv1E6VksMaIQq2QonGlWqPQ+hb0hnTQemXThCN4Hgh72x/6pvz
        l9NtitGTUIlfjnjjZh1pmD6Uo/EopFQ/xefFTED3Hf38q++vFzy57+VMQitnIw03mMPsin
        brCX0B+fN8ytGs/cv9YTwaK9ndgMje2Zx1HFAqYQru7RleHNz+nqVYEO7MET6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1665617812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=4qwRk9Nneh+nLe+v7dhmpAnk8JzWpiHmd4ynUajwX2Q=;
        b=AyyVSpYrP2rtvxQqe6qnW2vyinlyE0q8nASEQVxfQ1ajsjUhYcrXceizCiobeXd5/o+orU
        ShtULpMeiAQuKqKvm6Rzw3RF/zrZGk8/S2GMbkYzQAd9LGXRwk5lTagOcGPhMY7SmcaoH2
        UhPZjyRKvqOkyBYthpXtfDDFCKVgeJ0CzW12aaoHMQO6jzDMjo7cgC2HlGpr8z1Seea+Ag
        70QntTeQJRfMdu81IeiJ7Qtz4UljibRLv/Iz/ATqUfDssmbm4GK5PR8mrhltqYKKdGvl0p
        JJc7gZINC9Vvobbc8+r0NcqzV9qj4cbcFUg0z0kjltZUq23ITRw7VUEaVRuTDA==
ARC-Authentication-Results: i=1;
        rspamd-5798657bcf-wzs5h;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Tasty-Eight: 1986dbdc57fcd20d_1665617812681_383227744
X-MC-Loop-Signature: 1665617812681:2244649294
X-MC-Ingress-Time: 1665617812681
Received: from pdx1-sub0-mail-a209.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.97.34.85 (trex/6.7.1);
        Wed, 12 Oct 2022 23:36:52 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a209.dreamhost.com (Postfix) with ESMTPSA id 4Mnpvl2Wgqz3h;
        Wed, 12 Oct 2022 16:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1665617812;
        bh=4qwRk9Nneh+nLe+v7dhmpAnk8JzWpiHmd4ynUajwX2Q=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=EDhuqwXe27I4q8f0CxuofIbOUk1r3GlZsqguY4qfNhr3gQ1IyztjzV7419J7tMhay
         3RPMccfJBE2H6ak3LEPIwkvlOwU9Ha36b2qlzJB5Rh7kiNUgfAMjAPre4JQR8+JtPg
         19Jv5OH6HMTXtcv/kf7kJYjAf5YfZN5laaLrrqSfPP+ctCxn5QfdcX1fQFFpKDi4uc
         DIF1MmGhvGrmv7qE46nQbAYtqPNdY01UgwIEJB9Im812Ih8fTPpNdAbKQtdzUV6TCB
         5+P54XSMHmEUPvjpsWfNT9sue5m2WeJEHkNW6Bt9oK3UcoEg/f0lES5Soms5kvXv5x
         ryUzikaY7Uazw==
Date:   Wed, 12 Oct 2022 16:15:58 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        Jonathan.Cameron@huawei.com, alison.schofield@intel.com,
        vishal.l.verma@intel.com, bwidawsk@kernel.org,
        a.manzanares@samsung.com, linux-kernel@vger.kernel.org,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl: Add generic MSI/MSI-X interrupt support
Message-ID: <20221012231558.m3qhtsuagpvg22tt@offworld>
References: <20221012180432.473373-1-dave@stgolabs.net>
 <b155c6df-adb6-6136-c3b4-4a2c66110ecf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <b155c6df-adb6-6136-c3b4-4a2c66110ecf@intel.com>
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

On Wed, 12 Oct 2022, Dave Jiang wrote:

>
>On 10/12/2022 11:04 AM, Davidlohr Bueso wrote:
>>Introduce a generic irq table for CXL components/features that can have
>>standard irq support - DOE requires dynamic vector sizing and is not
>>considered here.
>>
>>Create an infrastructure to query the max vectors required for the CXL
>>device.
>>
>>Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
>
>LGTM. Although it would be nice to see the other half of the picture.
>i.e. having the mailbox consuming the vector via request_irq() as an
>example.

Well Ira has already implemented the irq support for the events[0], and my
plan is to send my mbox irq patches along with the async handling stuff
once this patch lands.

>
>Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Thanks!

[0] https://lore.kernel.org/linux-cxl/20221012180136.tc3ryjumquvnaqk2@offworld/T/#me42f5ff69bb78ac47ce94b647e6628fa3e841696
