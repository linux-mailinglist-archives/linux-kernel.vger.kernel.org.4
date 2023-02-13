Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48BD469515F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 21:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjBMUHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 15:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjBMUHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 15:07:22 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4B01E1FE
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 12:07:21 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id bg2so3720723pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 12:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7hiw45ltvpY/7ML6LM+IxRW/koSE15OxDQ83L5S1mw8=;
        b=nzKX+9e9U5sWB0Yrn4wYgD7cSAfhSs9Q6u8uIPdIVyqSk9aQ3itsbJ8YQZ16EsiucL
         z+lpmX8Rj+iYCxjsyhdrMCNMF4A+AdqbdgkOtWWYtCYvBTSfYaejZ/+XG6L/xEQFPJu4
         S2E4VIto+8UvTM5Org7d3gsoUewpCnPNyWgefW6MszzyOz95ebFtifssi5ElmXzDhTJq
         cB42eanVaEyID4tKlrQoe/Z2o1XTKsMAIFu/POZ/GRghb3hca7O3GiVpevaA8OJX25i6
         XTbWUXLQfAgpaHZD1/gFqZIIiXCpMVm2Rn1OYtUbeNT0bNKbv5iTCslPYKkcapKimOoC
         1z0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7hiw45ltvpY/7ML6LM+IxRW/koSE15OxDQ83L5S1mw8=;
        b=JPYuE1s1hG8S8ite01tcKICPhZC1vhEnR6IFbuo6Rg07ajBnXSHN/FNJEFBiqLQxz9
         fHe/70RZk1Fwa6JctjMHY1W1HxfVqYtuvl+RF1/mHO4y1Rn/I3Srk8h/53cSOqZSn2q0
         bBssRET54kWg8SkX7jQBEnuub/gxgCU73qNkNVhLyqaQoSS8k/E8ONumHb/Rdt1OAIFX
         hWmSeiqOlX8eejxV77nb+BiSvpAN9RVXv2aatrSylcga+dudJtaYr/9bbIH7RKWoE2WY
         dR0yKtDqKD/L9I/wGjUX+qq6u+O5DVt1mWzGdHk0RYgldI4NKcdlo4et7jQwbbilZtK7
         MX4g==
X-Gm-Message-State: AO0yUKXilkb6NY9nCuSo2l2S/CuMP3yCLzvU2DI+BWG6/vJ/vejbrCOx
        TIrOG9J338WD8nRQ0OzrxgCqPzDVUTZFSKTd0DU=
X-Google-Smtp-Source: AK7set+zBH7R/t8F8d5i8HeInR9uwLS0bM9n6S+OacY7EFetFl6bMeKJimvebjvRmWPFgqzqAqZz9Q==
X-Received: by 2002:a17:902:d4c3:b0:19a:621d:cad with SMTP id o3-20020a170902d4c300b0019a621d0cadmr141889plg.18.1676318840747;
        Mon, 13 Feb 2023 12:07:20 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id s17-20020a170902c65100b0019309be03e7sm8600978pls.66.2023.02.13.12.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 12:07:20 -0800 (PST)
Date:   Mon, 13 Feb 2023 20:07:16 +0000
From:   Carlos Llamas <cmllamas@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Jialu Xu <xujialu@vimux.org>
Cc:     linux-kernel@vger.kernel.org, Jialu Xu <xujialu@vimux.org>
Subject: libpcre2 breaks COMPILED_SOURCE=1 tags
Message-ID: <Y+qYdA7OpRX16Lwf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Newer versions of libpre2 have dropped default support for \K in
lookarounds. Unfortunately, scripts/tags.sh relies on this option to
collect all the _compiled_ sources. This is the error:

  $ make COMPILED_SOURCE=1 tags
    GEN     tags
  grep: \K is not allowed in lookarounds (but see PCRE2_EXTRA_ALLOW_LOOKAROUND_BSK)

It seems there isn't an official maintainer for this script and I can't
quite understand the regex used for the query. Does anyone have a good
alternative for this? The regex pattern was introduced in commit
4f491bb6ea2a ("scripts/tags.sh: collect compiled source precisely").

The previous form of all_compiled_sources() seems to work for me and I'm
guessing it wasn't efficient enough? I can't find much info about the
switch to find/grep either. I believe the initial thread is this:
https://lore.kernel.org/all/20200423103801.GA3730892@kroah.com/

--
Carlos Llamas
