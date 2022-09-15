Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B935BA261
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 23:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbiIOVga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 17:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiIOVg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 17:36:26 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E794888DE6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 14:36:24 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id sb3so15423596ejb.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 14:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=wGAyWEAabIbAvSogDrOIIx1zF8AmPT7zLl8Lu7dPpE8=;
        b=pX5VLD9pMWT1ix23xz+4or6aBpV3oaRY3wh7BRmCKsLt3isoxT1BZUpdznrzqFlKrq
         trWK4zS/EWvY6LfYOqmlFMUhoNLrPVcZ39l0BqAvNJS932NwvLFRFCBU48YySJOMNOnN
         8Qua3tORKMqA6NgBRJHux+VP3XsOibY1Y0mnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=wGAyWEAabIbAvSogDrOIIx1zF8AmPT7zLl8Lu7dPpE8=;
        b=fjV6A81mQ3ZM6WRw0sKJBeUuqlb3G+nt526iRqBiBzrc9eyGfzjR3u/TdY3FS/eUPC
         UoC75QXY/DKlT/MZsNFnpY1Kz9q26MiPrEAc8tw6b8T3f9JELFsxqZI9kwk712V04ApS
         w3KZuMrSuLWQ8sLtdLqjKcKFlkVqHzM7xOkq262RTwO8HSMPGiTfZI/6vTqSLdojw6RH
         svSQj7NWxVl3vlS6x9Fw1NDSRcWvqRHBcy0arMeVI+3zMBt7vRyCQ5StS7PHcGhX0gh0
         W6mLALGKv08wY1KBe2AGIQG+gLo9PS+e43lU0CApadr02oubQ4OWrqim8FqAKb2qqGHZ
         V3zw==
X-Gm-Message-State: ACrzQf3jEtOz+LfVfYo9fhdhRe+6sSNgTjP1awmwqqFs2QhZoavqbID4
        oQt5bCdYfoDnOhPCR4P2aMZZkVHoEz1RwlZKwy/Wug==
X-Google-Smtp-Source: AMsMyM5oMi1bUIySegT87LumTJnJw5zkfpcovyyEIUA3RlANhh7LLaQpa0Ghae6Zs5vw9F2bAc4ZRu1Jaf+f7VnBT4Y=
X-Received: by 2002:a17:907:6087:b0:77a:51e9:8e86 with SMTP id
 ht7-20020a170907608700b0077a51e98e86mr1293921ejc.31.1663277783495; Thu, 15
 Sep 2022 14:36:23 -0700 (PDT)
MIME-Version: 1.0
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Thu, 15 Sep 2022 23:36:12 +0200
Message-ID: <CAOf5uwk=Tx+W-JuJBXUYjt2BLmSvr9Q153D1RTyJG_cmeO4AUw@mail.gmail.com>
Subject: Correlation CMA size and FORCE_MAX_ZONEORDER
To:     Mike Rapoport <rppt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

Working on a small device with 128MB of memory and using imx_v6_v7
defconfig I found that CMA_SIZE_MBYTES, CMA_SIZE_PERCENTAGE
are not respected. The calculation done does not allow the requested
size. I think that this should be somehow documented and described but
I did not
find the documentation. Does it work this way?

With CMA_SIZE of 8MB I need to have FORCE_MAX_ZONEORDER=12 if I have
the default FORCE_MAX_ZONEORDER=14 the min size is 32Mb

Michael
