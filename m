Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D466F61C0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 01:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjECXJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 19:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjECXJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 19:09:15 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B097684;
        Wed,  3 May 2023 16:09:14 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id DF7B98C1E8F;
        Wed,  3 May 2023 23:09:10 +0000 (UTC)
Received: from pdx1-sub0-mail-a235.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 826388C29CA;
        Wed,  3 May 2023 23:09:10 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1683155350; a=rsa-sha256;
        cv=none;
        b=18eezlHbrDnxiVDU4AMm9Pym1cl7ZAQ/KHifhxCQUdo2G+GCUDF106R+FfRvkQqlDgInKI
        zDj3SUy+Ry/+WMEUHLT65LMOCYTQL0tdoBNXBCdb70zqGueyhOrtZXyEc04Eud5bBAyril
        e7IMb8IO0s/YU1gLcrz1t/Yd9ZOMKVECiUjzRiDchzVXB4ZwK00rObOWptPStksWG+l+GG
        //dFdVtG7UijdK/4Hvp0IWUdLr7b1HDJDDB/uW80qLUm51ry8T63mv1JWI/XS1TirN6H/c
        OhPmWXBdf633+k88Z3HH8IYjq5kxB0Y+5oU5U/8b2howOUHuMRb8N7UUtREO3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1683155350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=bBMecEvKISJytyJsqOyW7L7OQkz3v+qRAF4JpTKnzlY=;
        b=uk/tndL9CcoQSKRSk+pnTR6VTx9YpAS+eQ11yd9rGg78gxivO/bzvrGgy74Fer0ocx0aGz
        e/hlduuVf0YrXDLomzbcC+cR2g/g3PU+Um7Jpcu7iBH4UC4AsK1p8V8zC0Als7B23Cw9yK
        vCOBM+Zo7rTth9TcB7h7+f9gHiYmLUEQv6iOeVLdhMbxuToEjlTpjdVW1Gr4KYDp1frWU9
        HCnHA2hyMO+nBuyG96uLod0WRiOLqnhDOoMWn3FaOEG7V5uUPKZKtH8WPN+q3P2LydwSTW
        ZPId9M5JRzOwTU//wdyeaJAzIWx5w8QQBxOUayDxeJRWaVzg+zMjQ2h6oP1CCA==
ARC-Authentication-Results: i=1;
        rspamd-6bfb6b59b5-jw9xs;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Print-Power: 333c344e56d3adf0_1683155350697_1696751942
X-MC-Loop-Signature: 1683155350697:1831829536
X-MC-Ingress-Time: 1683155350696
Received: from pdx1-sub0-mail-a235.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.125.42.180 (trex/6.7.2);
        Wed, 03 May 2023 23:09:10 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a235.dreamhost.com (Postfix) with ESMTPSA id 4QBXh5690jz30;
        Wed,  3 May 2023 16:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1683155350;
        bh=bBMecEvKISJytyJsqOyW7L7OQkz3v+qRAF4JpTKnzlY=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=cKRsJYnBaC7l/sExHwAEgpJ+osBHvv7z7baXDGd4gXCCju3qsFrZRQqiMEwiqIEk4
         h2gTNFTOqSKtnTz1c/K26WjcbonQibGlv9sGWjBWUzRjbquAicAZknAwML5qIoyOVx
         F360AcLGeFbohDh8nhkPbau6om0Q0rO42S0OhEF1tdIDYseXNXwQnAt3LXv0cRyGIz
         o5qY3HvN9UHw6bSa3S444sE/CiSHhxW2jbe42N6mOv+3Bg/xNmCkDrd9mVW6ufb5sB
         LtRaQ+4gOTYy/USzDeoQK1Z47jLJI/KjRwav02DVloRrnEEtK3iJ41Kqyu/1nhMmeZ
         AWR9lQA1Sw7dg==
Date:   Wed, 3 May 2023 15:36:50 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Raghu H <raghuhack78@gmail.com>
Cc:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] cxl/mbox: Remove redundant dev_err() after failed
 mem alloc
Message-ID: <dtmb3d2dmcqh2djc4jebd2s7uwhw6l7nyfqgo7o34bhn7gzhzd@jmhb5g7edce4>
References: <20230428012235.119333-1-raghuhack78@gmail.com>
 <20230428012235.119333-2-raghuhack78@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230428012235.119333-2-raghuhack78@gmail.com>
User-Agent: NeoMutt/20230407
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Apr 2023, Raghu H wrote:

>Issue found with checkpatch

fyi for both patches, these are not "issues" - you can remove it, or the line altogether.

Thanks,
Davidlohr
