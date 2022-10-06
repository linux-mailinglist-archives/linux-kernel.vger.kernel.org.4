Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1025F603B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 06:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbiJFEki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 00:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiJFEkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 00:40:36 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB2E205D5
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 21:40:34 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id b7so790702wrq.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 21:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=W20YO+ov4MxRziyHM1SI1VpdCNExQwzglal8qUn3yOs=;
        b=ieEUL15ilFWFzBLPHjIonJNmarcTcWuNiA9cTQgxMFqxju4Uw+n7PQUv3gy0zAp2de
         OndsqECKVwajTebvBSD2PHZhV7EdM9UpJ4YsEa4etwDv5G76dEwiLAzaeAyMGY+EJ1Nj
         AvX7fpsYFcl0cK/tQYZChYVOphn9W8T+CeXTLFUz1LyOHwmmAtt+s0Z7+RnWTU9VEJEq
         CZVzP9Uqy4Nl2pnV02eIrkiT07Rj66kSl6egpSjkvE+0+LXceAsiv+NHNwwbetUI0USd
         +Or2aZTjIfHEgAG0aW2hdsVOX2fAP5o2yVswfv3sDUESOmKP5eVG8TB5eyu/fsnxODZm
         iuLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=W20YO+ov4MxRziyHM1SI1VpdCNExQwzglal8qUn3yOs=;
        b=Cq2S3iKO43miwxJ8V8vx1T3OM1fmtxFzDxysHnCrvVNSHo/5lkFpouka+tEZg50Fpe
         FNgRZ/FRFwGfRkS9bIiK3nTxDDgJCW9uPUiZziHDSgmAHPDWGt2V6NxwarJrfFjVAB2L
         9ePuVjLDIOi41WIFkcmf3DYVxfnH5fI1WBEXc2+8/+oDoCUEIGUSo0lrtsUOHkr3FPg3
         YXfaf2ruHpg0JxeVmDjFTCNEBAbdcTJ/rUpTgvAliPZ+3dbdlk7sK8I12JK3rzkCgatQ
         b26vrDzoexuVpTNkHzKxVCPKqbZg1TCfJfUyXqlEs3vj8D3xnwwuOZNNznuJz38Pu018
         a3vg==
X-Gm-Message-State: ACrzQf3X2qOa9Cso/k0PA5a0S2gejDgCqF3bJPm4yVIKbHKAwKbUKex5
        n5jfL5VwdxiNo3VyNiztCCQ59JLYVH/5LA==
X-Google-Smtp-Source: AMsMyM7Q7eJNGISjWmPrlBF7SIhKpMN3mHJGgvr4E3Lw5FtO16VrLJy3gDAMwqL6eS01kmlSb4JblQ==
X-Received: by 2002:a5d:5148:0:b0:22e:53bd:31c5 with SMTP id u8-20020a5d5148000000b0022e53bd31c5mr1591157wrt.241.1665031233120;
        Wed, 05 Oct 2022 21:40:33 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id t2-20020a5d5342000000b00228692033dcsm16500289wrv.91.2022.10.05.21.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 21:40:32 -0700 (PDT)
Date:   Thu, 6 Oct 2022 06:40:31 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     davem@davemloft.net, edumazet@google.com, khalasa@piap.pl,
        pabeni@redhat.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH 1/4] net: ethernet: xscale: fix space style issues
Message-ID: <Yz5cP82JRuvZHh+I@Red>
References: <20221005120501.3527435-1-clabbe@baylibre.com>
 <20221005203545.48531d8e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221005203545.48531d8e@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wed, Oct 05, 2022 at 08:35:45PM -0700, Jakub Kicinski a écrit :
> On Wed,  5 Oct 2022 12:04:58 +0000 Corentin Labbe wrote:
> > Fix all checkpatch issue about space/newlines.
> 
> We don't take checkpatch "cleanups", especially for fossils.

Hello

The difference with classic checkpatch is that I have tested it.
And the patch #2 fixes the bad netdev_debug().

Regards
