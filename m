Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1FEF6AD53C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 04:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjCGDEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 22:04:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjCGDEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 22:04:52 -0500
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA6F3CE33;
        Mon,  6 Mar 2023 19:04:46 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 84AE15C16E7;
        Tue,  7 Mar 2023 02:57:55 +0000 (UTC)
Received: from pdx1-sub0-mail-a206.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id E90D05C1D03;
        Tue,  7 Mar 2023 02:57:54 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1678157875; a=rsa-sha256;
        cv=none;
        b=brtdpSsD6WYMbXYYLl0NeBJ1BwctoFrfmf7XMzTIgvDs+RtAkU+kR9rq7zk8R+8ymbaqeq
        9VXTQNtysFCL6+CjOx6mzAVC/csxTf2dYnjRiaLYLE1ocy2wtxtUp04BoPgdoPUskNACdI
        nUHUR7hPq7P9dO/zdP+dehBFyY7wm5NXa5ojjXI9LFwwNYWzotRkrxMmGsblmG2+cCXKay
        WA/MqN7vUrDASItFbg8FXvvfcGqEPj67utTtR8zTpoIJ2mhJhHkd+MGqpVDL0OIMtf2J+X
        v7ejr/RuK3YAA1c6Y194NzLSsgD2/hp1UZ8asxJmkXrAlOgM6RQcP4tnNIoTqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1678157875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=aK3KZ/r+q1Rmu7SZI8mlZG80jn0VODLycg+e8svAcEw=;
        b=aTCLKMMROY8i6RfmtPyGOaTJ4RGBscU1nGr5PMb6w1cV7BiciPIprqywN80em2oqQrYRLZ
        d5q+nr0acihpKfF8PTkpFdQ7LDpdd/P0nk3nd/RJWZPjqaFC3s/+Qr3V2pDwung78fAYjZ
        p4pTNoaFPe3IOqM1MyjGzVmYb6AFzRzbmfjsDvYZR9OjNyEsolM5Qk6iRQ3n6PlyhZ5b0C
        sRgveb3tDucVFAzgCskeW34XlsxWsVdbeovq3qYiUwMhPmdUXlAzCatNPVz/yNqKhjUDmv
        5doJ8/FTEdr3hqOTsAWTLRFH8S2sm2OwlFpGKlW4XtCbqUCT1HzHKX3CYWDplw==
ARC-Authentication-Results: i=1;
        rspamd-69778c65cd-k7wj5;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Rock-Spicy: 5b95b6097b129fe4_1678157875337_2810228058
X-MC-Loop-Signature: 1678157875337:2286454054
X-MC-Ingress-Time: 1678157875336
Received: from pdx1-sub0-mail-a206.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.109.196.245 (trex/6.7.2);
        Tue, 07 Mar 2023 02:57:55 +0000
Received: from offworld (unknown [104.36.30.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a206.dreamhost.com (Postfix) with ESMTPSA id 4PW0Vn6MYrz94;
        Mon,  6 Mar 2023 18:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1678157874;
        bh=aK3KZ/r+q1Rmu7SZI8mlZG80jn0VODLycg+e8svAcEw=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=TofMmRO+fMu8iT67USI9daG0K9nt5THmHeSdL0ZJjMjiz20xnxiuR0ZWFJwDroLMp
         skJAotbno0/AwL8Mnx7TYiGhJdQRpMQG15p09BGKlALXZ7mtMQwh7mUd2dSTmWBUqn
         I2FyMs0ax9P1DJ8wg2j/PFQWyw+k14rc0rsRnp+cjRDmRXFXwMs0OJWUWgAhtI8Uee
         2oXbuVtx8G0T9KOGAZbNopJIFD6oUCFq/2wb/jfG5yF40uy7Gfm8qv5P3L5lUwaDcL
         TFuj30o9IAQGCdQt0u9r87j4PDF85fMG7PNNdKOrDDbPQ/zCsoVlXuS8LTXgduqlE/
         sMFMz7TJFUncw==
Date:   Mon, 6 Mar 2023 18:28:52 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com, will@kernel.org,
        dan.j.williams@intel.com, bwidawsk@kernel.org, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        linuxarm@huawei.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] cxl: Add function to count regblocks of a given type.
Message-ID: <20230307022852.bhnjvftcl3hffnp4@offworld>
References: <20230303175022.10806-1-Jonathan.Cameron@huawei.com>
 <20230303175022.10806-2-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230303175022.10806-2-Jonathan.Cameron@huawei.com>
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

>Until the recently release CXL 3.0 specification, there
>was only ever one instance of any given register block pointed
>to by the Register Block Locator DVSEC. Now, the specification allows
>for multiple CXL PMU instances, each with their own register block.
>
>To enable this add an index parameter to cxl_find_regblock()
>and use that to implement cxl_count_regblock().
>
>Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
