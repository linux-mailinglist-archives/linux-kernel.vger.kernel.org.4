Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B85660AB2
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 01:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236564AbjAGAPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 19:15:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjAGAPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 19:15:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D666473E1F
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 16:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673050488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LhnMM7fQD+toq0uk/bI2+XqyJ3TS/+0YVHHH9iY5RqE=;
        b=FDWco2ejNAHskSAisOM8Zn4AXtUuuc+pNzR/bSEK1Mft0Na/Ehc37kQ2t96mgz7cM1+XZB
        +67qoiDqrWFm1H92vMrHOyoSSkfRXFHxsjoOpt/V5QFSghPylxDbqGBCh32kqn6w1RaYKS
        pEkODf4krvDUkT3Et4R89J5Tlg/IT24=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-152-1tEsJEFJPIGgHLXSlwJUaw-1; Fri, 06 Jan 2023 19:14:46 -0500
X-MC-Unique: 1tEsJEFJPIGgHLXSlwJUaw-1
Received: by mail-qt1-f197.google.com with SMTP id z16-20020ac84550000000b003a807d816b2so1413516qtn.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 16:14:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LhnMM7fQD+toq0uk/bI2+XqyJ3TS/+0YVHHH9iY5RqE=;
        b=BHOhsFJie1o0vT8VNt+vtUKqiW7Ya3PzZM56vw1nF3dTL8I0QrvcZfemmtOR1PmBR2
         wDdF7x+6xghvRJbRoWeF6BrV/iq0SOL2NmJ+4j0cer8z8t5l/o/GjL8/o+iobZl0JOIf
         sQ72LGE6Z+trMAvQ8t7xIVEd9aEC1i2X4l75Ugsie5Ik5uiSSpEMb9RVuyTZhWGx40aS
         aCLVRlZrESIgT87fDMXV2+YT6CJNjJrn6VeeUteSjFk59PUef/K0MWJjCeqqdNacrr2/
         84LK2TYzaSUjZWbEMgRF7ORxlf8YeHmbDw3iQ+fEjPZ+70Jplr/vRhmK4tDV3FK/2yS2
         bJdA==
X-Gm-Message-State: AFqh2krxwWyuAP/SvRZY8NWEG7fofyoqFp1cNtvWD3b79PdZn11UDVcT
        tPL0pSrs7nq4i6uRD9hl2gm+UU/6xVXNoicaz2z5VhsB+U7vemKS9NWd2b1l++Hnh7r951tagCD
        LdgOjeoa8qL5S5WuXM6FTiMlF
X-Received: by 2002:a05:622a:199e:b0:3a8:1947:3e38 with SMTP id u30-20020a05622a199e00b003a819473e38mr101090297qtc.31.1673050486523;
        Fri, 06 Jan 2023 16:14:46 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt5pXym6h5UUuv4FRgsYP4KQoKWlKJuI0AixlVnJ08wan3o8pObcywtBAqxHWxXhiuqsfxSKA==
X-Received: by 2002:a05:622a:199e:b0:3a8:1947:3e38 with SMTP id u30-20020a05622a199e00b003a819473e38mr101090274qtc.31.1673050486242;
        Fri, 06 Jan 2023 16:14:46 -0800 (PST)
Received: from debian (2a01cb058918ce00e3192ce9ffef0fc4.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:e319:2ce9:ffef:fc4])
        by smtp.gmail.com with ESMTPSA id w26-20020a05620a0e9a00b006eeca296c00sm1316613qkm.104.2023.01.06.16.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 16:14:45 -0800 (PST)
Date:   Sat, 7 Jan 2023 01:14:41 +0100
From:   Guillaume Nault <gnault@redhat.com>
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     linux-kselftest@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: BUG: tools/testing/selftests/net/l2_tos_ttl_inherit.sh hangs
 when selftest restarted
Message-ID: <Y7i5cT1AlyC53hzN@debian>
References: <924f1062-ab59-9b88-3b43-c44e73a30387@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <924f1062-ab59-9b88-3b43-c44e73a30387@alu.unizg.hr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 02:44:11AM +0100, Mirsad Goran Todorovac wrote:
> [root@pc-mtodorov linux_torvalds]# tools/testing/selftests/net/l2_tos_ttl_inherit.sh
> ┌────────┬───────┬───────┬──────────────┬──────────────┬───────┬────────┐
> ├────────┼───────┼───────┼──────────────┼──────────────┼───────┼────────┤
> │  Type  │ outer | inner │     tos      │      ttl     │  vlan │ result │
> ├────────┼───────┼───────┼──────────────┼──────────────┼───────┼────────┤
> │    gre │     4 │     4 │ inherit 0xc4 │  inherit 116 │ false │Cannot create namespace file "/var/run/netns/testing": File exists
> RTNETLINK answers: File exists
> RTNETLINK answers: File exists
> RTNETLINK answers: File exists

You probably have leftovers from a previous test case. In particular
the "testing" network name space already exists, which prevents the
script from creating it. You can delete it manually with
"ip netns del testing". If this netns is there because of a previous
incomplete run of l2_tos_ttl_inherit.sh, then you'll likely need to
also remove the tunnel interface it created in your current netns
("ip link del tep0").

Ideally this script wouldn't touch the current netns and would clean up
its environment in all cases upon exit. I have a patch almost ready
that does just that.

