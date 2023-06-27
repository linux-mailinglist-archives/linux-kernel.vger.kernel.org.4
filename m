Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6AF73F904
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 11:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjF0Jtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 05:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbjF0JtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 05:49:24 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30AD26AB;
        Tue, 27 Jun 2023 02:49:20 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-991f956fb5aso132175566b.0;
        Tue, 27 Jun 2023 02:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687859359; x=1690451359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oHO5L0CKePf0nx1WzjkZ43osHSYqQQGPhHym3aaajg8=;
        b=qO5rAvwN/smMmFzbyiWIu0rMttq3AYuV+WYyLvrZNk+UWd92aD670z3gcj95fsm4Sp
         KiFIEaYeUclD+8abfPD71dFEQjNHzOqZq1rMDHTcj7+tvxVow4zPFBecDAzkmwuID96U
         AWXS9AymQE8/JGCJo/T/9KdXD0jVBkF6xoU2U8p0qcSTAABELuXIHhgKAiEnfTILmhi0
         G1uWTw80MNT0VXHbkdlhtghsrRYqOzJgJ8iLZMpBGwVbgUk4oMdpmJFfnfazKef0H5d5
         HB8kcl6vAade7oC2bukA+Kis1k+BT/oQBna/r60aTWJgFiHMZKORMGUoX2FzzbveqZT0
         c+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687859359; x=1690451359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oHO5L0CKePf0nx1WzjkZ43osHSYqQQGPhHym3aaajg8=;
        b=Rnyaudqrcne2kWez/nFtXoAf28GoMk9762vxeVmjt1t9ssjMfJqAVikwNZN2XC21o0
         UG6jdJ7BvGLzW3/f9gI7Mr2JOw+2oXsMw16pGKhh5DZGc/v+yo1LPGMD4RvBJWr9rCks
         1Tg9jcPVuAZ1O/3kjbrzWtrCT0eWYopxZSfiU5SOik+aKzbWSDl0edq5n0N2U3JOchwt
         b4AQmArXveWrZwYlYXGXnpRgqbVMZCgQVX9PICi2JA9OmdJzSyHWoRGi/m904mylsF+c
         NuUesk8a0E9IpGxNZ4NsREphhUBoIDaJH5Qb2POGtIXW3n4bIxX0qpq/A1cH3Igsv66K
         +4uA==
X-Gm-Message-State: AC+VfDxlfySRi2Pp7U2QW6rPd/cFm8tXE3FU17sW6fmpRGejyxhg4g5u
        woWtJKShMmppLWVX1JAWG8w3zSmRXkbDMw==
X-Google-Smtp-Source: ACHHUZ7I9IpuLQIKVdit0zfxC22+fK8Wm13jkuBFiDZHHWpLscVc5Cxzd7lO3aVutO+uosxlYdixRA==
X-Received: by 2002:a17:907:1c08:b0:992:292b:6a60 with SMTP id nc8-20020a1709071c0800b00992292b6a60mr990207ejc.26.1687859358792;
        Tue, 27 Jun 2023 02:49:18 -0700 (PDT)
Received: from skbuf ([188.25.159.134])
        by smtp.gmail.com with ESMTPSA id gu3-20020a170906f28300b00988ca8b175dsm4272623ejb.119.2023.06.27.02.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 02:49:18 -0700 (PDT)
Date:   Tue, 27 Jun 2023 12:49:16 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Atin Bainada <hi@atinb.me>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH RFC] net: dsa: qca8k: make learning configurable
 and keep off if standalone
Message-ID: <20230627094916.maywojwztzdek5y2@skbuf>
References: <20230623114005.9680-1-ansuelsmth@gmail.com>
 <20230623114005.9680-1-ansuelsmth@gmail.com>
 <20230625115803.6xykp4wiqqdwwzv4@skbuf>
 <6499c31c.df0a0220.e2acb.5549@mx.google.com>
 <20230626173056.zq77nilzrr5djns5@skbuf>
 <6499d3f5.050a0220.3becf.7296@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6499d3f5.050a0220.3becf.7296@mx.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 07:59:41PM +0200, Christian Marangi wrote:
> > Hmm, so ping works but this doesn't? That's strange, because send_uc_ipv4()
> > also pings. Have you run with bash -x to see why it fails?
> > 
> 
> I just run with bash -x and I also mod the script to not delete the
> tcpdump. Limiting the script to only this test the dump is just 2 ICMPv6
> packet and no output from tcpdump aside from
> 
> tcpdump: listening on lan1, link-type EN10MB (Ethernet), snapshot length 65535 bytes
> 3 packets captured
> 5 packets received by filter
> 0 packets dropped by kernel
> 
> I feel like this is important so I think I should focus on understanding
> why this doesn't work? Any clue?

No clue. I'd put a "bash" instruction in send_uc_ipv4(), which would act
as a sort of break point for the script (opens an interactive sub-shell),
then run it again with bash -x, manually repeat the command that failed,
investigate why it failed and hit Ctrl-d when I'm done.
