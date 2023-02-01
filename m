Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5266E686B78
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 17:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjBAQYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 11:24:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjBAQYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 11:24:46 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFEADBCB;
        Wed,  1 Feb 2023 08:24:43 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 35FD37E1092;
        Wed,  1 Feb 2023 16:24:42 +0000 (UTC)
Received: from pdx1-sub0-mail-a221.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 93E7F7E1833;
        Wed,  1 Feb 2023 16:24:41 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1675268681; a=rsa-sha256;
        cv=none;
        b=k5Hl/+1VqHnQE5h6iaeLNKlyabU9PxObDnT+CZPFyWg/t2djrSj3aMZEdSqjhUjISgrFog
        AwnKgscHNeevmlP859kTIIIErn0JtbFdEwSr0yvMvyRQpTztkd0RzPRjxtiz8kQDZTZofC
        qHcv+semoMd/lsS9hGJblLctlufvVPZZpj64pnk1zr86Roh4tdNJxm1Gv/sO3BtsgeAtQ2
        nNh1tmWt6R8nOMSaV/7N5PjLeSSsGjM1Xd9jLHiiN42N6yfWFnvQdar7yYC9uqg0ZxIUB7
        +EKqOpyJEt/qwIEKakBcfQ7+RQTJ/B6gFnCiB4nJNT0DsvVV4XQr5FMDGrk7lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1675268681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=2bdI4TPDn3elYpB6pyzaj01gJj8K33x3qyWJhEoPEM8=;
        b=LbZGUF6QSs3y7wOPxFBhRqB3D0H3roqdQ1rL4qwrx6C4NA+YvZav2ZA1UpoBrhfmyb32AK
        60B99/Wj/zACupc15wXGeqaIR3n6bdP7FlseI4WUKfkNoQLDygHUbzLpHbqCVUN5UJVrJZ
        iMVuJUphYI4qmdVYdJP7k0muIDqSHqjPTZiT2acd57PN1kpDMrXHdZXfbR1+CCjU1aEGH6
        87mqI3x953PArjO7tzAnfwy9oz7WKz7R7t1xfLVyyV0lL5IGPDkY6h2i78j0T9zZuOz3dG
        LA5He9zX9NXWbqKidnWTF2WEZUWkn6ywdCPiNdyaNml2mLB7tRW5+fJqffBjhg==
ARC-Authentication-Results: i=1;
        rspamd-5fb8f68d88-2xntm;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Sponge-Versed: 3d14cdde207f1031_1675268682015_240600750
X-MC-Loop-Signature: 1675268682015:2355844550
X-MC-Ingress-Time: 1675268682015
Received: from pdx1-sub0-mail-a221.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.123.200.120 (trex/6.7.1);
        Wed, 01 Feb 2023 16:24:42 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a221.dreamhost.com (Postfix) with ESMTPSA id 4P6S1M6qCqz9t;
        Wed,  1 Feb 2023 08:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1675268681;
        bh=2bdI4TPDn3elYpB6pyzaj01gJj8K33x3qyWJhEoPEM8=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=Udzue+WIdmQOAtw7WDMz1KaYZmcXYFd6qamRuW7aQPDrtdWa4shS7pcl5orFfkVKJ
         GuhZ8gUO031w5RLJI8K7HMhU+TbMpPK+kJ18I2wpBJj2zEy5mCTv2kbjydDSEDKxXr
         IJu3TYdTBXbA8NhyqiX8rBH739c62xVrVw9q6ATkjttoqEQFMWeDeVrG1S9NpED7fx
         m2ohl51LHhUK/V57sb1r2jCsX4oJX3FAuzWH2uEc6Gldn0CrVf+AndPlgWG+z+mR/y
         Qw/3Esbdav7osvAx5PnkybLo4vJjiLuntt/LmqKTZ3gP3CU9NHqBFC6M6o3+wqiIn5
         22V+0Kqw35iHg==
Date:   Wed, 1 Feb 2023 07:57:29 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Fan Ni <fan.ni@samsung.com>
Cc:     "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/region: Fix null pointer dereference for resetting
 decoder
Message-ID: <20230201155729.wnil24dijtd2rfhl@offworld>
References: <CGME20221215170915uscas1p262ccdf32fb2ccd3840189376c2793d06@uscas1p2.samsung.com>
 <20221215170909.2650271-1-fan.ni@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20221215170909.2650271-1-fan.ni@samsung.com>
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

On Thu, 15 Dec 2022, Fan Ni wrote:

>Not all decoders have a reset callback.
>
>The CXL specification allows a host bridge with a single root port to
>have no explicit HDM decoders. Currently the region driver assumes there
>are none.  As such the CXL core creates a special pass through decoder
>instance without a commit/reset callback.
>
>Prior to this patch, the ->reset() callback was called unconditionally when
>calling cxl_region_decode_reset. Thus a configuration with 1 Host Bridge,
>1 Root Port, and one directly attached CXL type 3 device or multiple CXL
>type 3 devices attached to downstream ports of a switch can cause a null
>pointer dereference.
>
>Before the fix, a kernel crash was observed when we destroy the region, and
>a pass through decoder is reset.
>
>The issue can be reproduced as below,
>    1) create a region with a CXL setup which includes a HB with a
>    single root port under which a memdev is attached directly.
>    2) destroy the region with cxl destroy-region regionX -f.
>
>Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
>Signed-off-by: Fan Ni <fan.ni@samsung.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
