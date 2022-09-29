Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2BD55EF95B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 17:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235694AbiI2Pot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 11:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235821AbiI2PoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 11:44:19 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFD9286C7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 08:43:15 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id e68so1806533pfe.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 08:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=b7VI/lNtki3zEef+0LBeBHdkR7jGYNMrvxJja3PqG/c=;
        b=Vzksrx3sniIo56OPl72BWHlU0/Df8j/JQCbDZvy1EGrf7kGm7B2aiZfENf5gW44D/J
         gI9Z0IM1eNvyuoepwUgJtEreELCtd/Yi97PNwccOEhM6E0notm+GqKPkHLkR9oYsyKb8
         Yoq/pleXGN8k4RyGciZfN2tWjdiAPNPkdJ0GRF8seENVYF2FOicZ45TlpxCNGouCgsOp
         P0XmWHkJpwHysnW3nZxveeGX+rb2ESXrOcsYARReYp7X/HAFCqXhQu1KdtVjt8W5CRIo
         QDL3OSbkonYl6GqgtkUeoFLMwgh1qC0e+3cPxCbPucD2iWViRSqwTxmu6i6Uq7X8iEVv
         wfYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=b7VI/lNtki3zEef+0LBeBHdkR7jGYNMrvxJja3PqG/c=;
        b=suS0+avmrs9uo4KwQrs4A4qBzdnENwssthIeNEZKPG85G6bMFKJtPbg08gkNnv3mBM
         Fav7sC/qigRl7KwKFp1Kc4VgbCG2mu2yTxVZeEjb39CKAD/s/Q4rdm03fYSLSl81qtOe
         PqeRgh2/ha0YCAkyS0QtvVshroZ5hwS4PABsoll1whWYL/uGeyYqX2V+yjr3fLWlUbtu
         9dCLwEtqWBAjxh9IZq9xrQbmIACLG7kzOTTneNKO4QWf1xm5KB1ea2uXyYhHq8rdZ4Fi
         9LKulkO/3Nky5tq0hVK4S1opfzJHZ4dr4n1pEqVPLgjJBMuR8bOQdzU00tcPrCTLkE7s
         1WZQ==
X-Gm-Message-State: ACrzQf1bjRtgKmJ9eFtLJyhtCRKl3u99nHe5hZh2N+gRq4TCWvSKUIhB
        Ija9Wz6MEOwXYJqBNO3bpW/7mQ==
X-Google-Smtp-Source: AMsMyM5rOGzlC007WW3U9p2PPqvx0IpfKhVuFQ42vcDUakNLelXGGyhbF2WyHTattavi5pSMM7s+ng==
X-Received: by 2002:a05:6a00:1412:b0:557:d887:2025 with SMTP id l18-20020a056a00141200b00557d8872025mr4076191pfu.39.1664466194646;
        Thu, 29 Sep 2022 08:43:14 -0700 (PDT)
Received: from hermes.local (204-195-120-218.wavecable.com. [204.195.120.218])
        by smtp.gmail.com with ESMTPSA id z3-20020a170903018300b001768452d4d7sm56745plg.14.2022.09.29.08.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 08:43:14 -0700 (PDT)
Date:   Thu, 29 Sep 2022 08:43:12 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Hans Schultz <netdev@kapio-technology.com>
Cc:     davem@davemloft.net, kuba@kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        linux-kselftest@vger.kernel.org,
        Joachim Wiberg <troglobit@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Ivan Vecera <ivecera@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Ido Schimmel <idosch@nvidia.com>,
        bridge@lists.linux-foundation.org,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Roopa Prabhu <roopa@nvidia.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Landen Chao <Landen.Chao@mediatek.com>,
        Jiri Pirko <jiri@resnulli.us>, Amit Cohen <amcohen@nvidia.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Hans Schultz <schultz.hans@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Yuwei Wang <wangyuweihx@gmail.com>,
        Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com,
        Vladimir Oltean <olteanv@gmail.com>,
        Florent Fourcot <florent.fourcot@wifirst.fr>
Subject: Re: [Bridge] [PATCH iproute2-next 2/2] bridge: fdb: enable FDB
 blackhole feature
Message-ID: <20220929084312.2a216698@hermes.local>
In-Reply-To: <20220929152137.167626-2-netdev@kapio-technology.com>
References: <20220929152137.167626-1-netdev@kapio-technology.com>
        <20220929152137.167626-2-netdev@kapio-technology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Sep 2022 17:21:37 +0200
Hans Schultz <netdev@kapio-technology.com> wrote:

>  
> @@ -493,6 +496,8 @@ static int fdb_modify(int cmd, int flags, int argc, char **argv)
>  			req.ndm.ndm_flags |= NTF_EXT_LEARNED;
>  		} else if (matches(*argv, "sticky") == 0) {
>  			req.ndm.ndm_flags |= NTF_STICKY;
> +		} else if (matches(*argv, "blackhole") == 0) {
> +			ext_flags |= NTF_EXT_BLACKHOLE;
>  		} else {
>  			if (strcmp(*argv, "to") == 0)
>  				NEXT_ARG();

The parsing of flags is weird here, most of the flags are compared with strcmp()
but some use matches()..  I should have used strcmp() all the time; but at the
time did not realize what kind of confusion matches() can cause.
