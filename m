Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21CD62481B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 18:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbiKJRSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 12:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbiKJRSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 12:18:38 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10DFA4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 09:18:33 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id gw22so2087717pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 09:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+p59de6PsfQhghSr17SHi1vccXQnsphuAQf+FEG0HQ=;
        b=Je1AWEgls8fX5fRsqqjYq3EJyLyKV7MZf9N1T/aVClFk3POIrv7COzBf4FD4SvUbaP
         LgJaDOWNYXSDnktSJmsWkSVj6P7JqWVj7LF2N+1U14bXHgd3p+dvL13CNSdD893hgjKD
         KQ+2SoOBhw6bBhFDkRa0HfyH5zVpnvKnr4EztAJZlVvTCUM54LG/KK+sZVgaXBj2wDY7
         hFU6/DI/xCNfQGkvqJXN6leNlFpiQFhrZCTkMjHP27GLQ/eNIBn/FlcFC0msGuxVAv2r
         1+4J+/xM3iuc4acHtoFrpL+P+y3rKIRpP8/05PVHb79EJCpBdlkVnF7qNHg9yso/U3Ll
         DFFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6+p59de6PsfQhghSr17SHi1vccXQnsphuAQf+FEG0HQ=;
        b=RkqnNrGT84oF3rtLtYRd0k3woIOPiigqhVELcNFDzrsp+dJApNUkMBnmfMECoixixE
         GGN5/G08rWt16e6PfQIbSzsCqQyUCGjQtmDkUVQIYwgUtZqu67gvI0tjgLuaPZnOAD9x
         wJWNlu6H3G/GcApIDRtf1wxS1q3Mk8QtpVwjQ4uaJzo8XLOPRf2nBof+HckWHLvvtPdk
         WeNMam7QVMnjSwrM7Jrr0Qyo8BZaAEPUiU/9Kyj5EEIEFvp7zZSAQmvCtkuKJa0O5t8M
         qdB08nEAiOb70GjoF8tHCXXXdR5qMPd6I7VNoVEUInOp42/EpRuRlXH7D54vsFkFsi9s
         3dfA==
X-Gm-Message-State: ACrzQf2ciKy2M9zcbR0f8/w9EJhgW8ZomKwBjowH4eecFNv4oJcM4YEd
        465hYNep+PbQ0g5y32tC51bCrLrAG9fvQA==
X-Google-Smtp-Source: AMsMyM6ymq/lxyuKszNR0m9UH9h7DZ+Sebq+bjrStgM3F+5tXEmSshH7ePAkNpgR5kzXnE0dJWyDVw==
X-Received: by 2002:a17:902:e74a:b0:187:2039:5754 with SMTP id p10-20020a170902e74a00b0018720395754mr57814067plf.103.1668100713125;
        Thu, 10 Nov 2022 09:18:33 -0800 (PST)
Received: from localhost (fwdproxy-prn-021.fbsv.net. [2a03:2880:ff:15::face:b00c])
        by smtp.gmail.com with ESMTPSA id z22-20020a630a56000000b0043c732e1536sm9427574pgk.45.2022.11.10.09.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 09:18:32 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     minchan@kernel.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ngupta@vflare.org,
        senozhatsky@chromium.org, akpm@linux-foundation.org,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v3 3/5] zsmalloc: Add a LRU to zs_pool to keep track of zspages in LRU order
Date:   Thu, 10 Nov 2022 09:18:31 -0800
Message-Id: <20221110171831.19176-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <Y2wh4b3oMaknNqGP@google.com>
References: <Y2wh4b3oMaknNqGP@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Please put the LRU logic under config ZSMALLOC_LRU since we don't need the
> additional logic to others.

I think the existing CONFIG_ZPOOL would be a good option for this purpose. It
should disable the LRU behavior for non-zswap use case (zram for e.g). The
eviction logic is also currently defined under this. What do you think,
Minchan?
