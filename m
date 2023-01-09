Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A66C662221
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 10:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237029AbjAIJwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 04:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234302AbjAIJvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 04:51:51 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0DE120BB;
        Mon,  9 Jan 2023 01:51:16 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id o13so4678597pjg.2;
        Mon, 09 Jan 2023 01:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ddVtdw8jXVuxIM0SuKPvP0VJu/NC/e0O6HjAii0zrz0=;
        b=YrCwP8zMH9Dd/hw10RPKEdIJW0IEHD8y3+BB9wn0N2uJzz+fITcbuaedimkTM5gt/e
         L1w+KPw/wezCP4l/upVTvA4yHfsl6ImwIazp3Icaim/rOWouyP2LaWxIqjGqtv5fTWdg
         jraGHeAAYyCc0su7F/jjY3dp/9WnZgkKhNkGCjBR5sc6T2Kr5HclbaOpVXgsBzUpA3f6
         xhokPmDAQAfJ0vq5hgrkjrqv1JnOmZhE1rGIxfMNubEul7NN9APYaOItPgkqUeSnQdYm
         42o7TwHyNUO8ZS3JpLO22fg1Nc80L2nWzdj6JI4/rmhrRRvnDiJ7LXrg6Tfhfl/x01De
         ILig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ddVtdw8jXVuxIM0SuKPvP0VJu/NC/e0O6HjAii0zrz0=;
        b=euC6utha1sczcEHHUY5V5LisNyu8Rgd1ABv95Ex1diyALknlwMLc+hRUY/wnUDaBnp
         2NBBExgeHkd5y7igd5U8TDXxGMQMcZDEM6AHikX4r7qfUjKW4PnsqZhMfUtNCrUCTgs1
         IVI7Ci7/HtJoYGtljSV9HyF3yTkMTY3r3slaP936CBpazKuYWS6NiiduIbpTFIwK8o22
         zIm0eo82Q4RG51CF2fubMR6+sdof9w3Zyd82XPfiER/Kk3biPk5ycGABZ/uCVIbGiuPq
         xkynyLIVkH8YkmjlRn9zeLEaxULVAA00uec52DkHxllmt07yEfpL/1aUQ+lcsZYkb12C
         8lpQ==
X-Gm-Message-State: AFqh2krPXuWbNHuiM+tw9nBoeZFWE3Sy3HHRvG2O/t605fh6pO9ozPUd
        lGF6rpCvXAMJLuHV+rzj5nk=
X-Google-Smtp-Source: AMrXdXvcBC942ucNE/7ppG+sYx4Em9Ddf9nXge/qaI2yHRpihEyxGIxXs8xpBhSHZzi1aHPOBq/Byw==
X-Received: by 2002:a17:902:b60d:b0:188:8745:35af with SMTP id b13-20020a170902b60d00b00188874535afmr77276434pls.63.1673257875797;
        Mon, 09 Jan 2023 01:51:15 -0800 (PST)
Received: from debian.me (subs03-180-214-233-26.three.co.id. [180.214.233.26])
        by smtp.gmail.com with ESMTPSA id x3-20020a170902a38300b001896522a23bsm5708062pla.39.2023.01.09.01.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 01:51:15 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id B5E3F105012; Mon,  9 Jan 2023 16:51:10 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Yann Sionneau <ysionneau@kalray.eu>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Clement Leger <clement.leger@bootlin.com>,
        Guillaume Thouvenin <gthouvenin@kalray.eu>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 0/8] kvx documentation improv (was: Re: [RFC PATCH 01/25] Documentation: kvx: Add basic documentation)
Date:   Mon,  9 Jan 2023 16:51:00 +0700
Message-Id: <20230109095108.21229-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <874jt7fqxt.fsf@meer.lwn.net>
References: <874jt7fqxt.fsf@meer.lwn.net>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3323; i=bagasdotme@gmail.com; h=from:subject; bh=rXyfPkWPotWjasnOdg5FQjgn15EEeIyMsS1vn7pUs+k=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDMm7H3dOXsR47++lRZdqH/269szJV+kkU4TTpiCxqfKrFkqI Oc7+3VHKwiDGxSArpsgyKZGv6fQuI5EL7WsdYeawMoEMYeDiFICJ2GxhZNjwTkLLb3rPJtOEvPy1Cy NP77brKFvanLP3gwbzlIK4fntGhhcTutUklnjyhb4z2P7u8IETWxMsP96c894v0TfR67imBjcA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Corbet <corbet@lwn.net> writes:
>> Add some documentation for kvx arch and its Linux port.
>>
>> CC: Jonathan Corbet <corbet@lwn.net>
>> CC: linux-doc@vger.kernel.org
>> CC: linux-kernel@vger.kernel.org
>> Co-developed-by: Clement Leger <clement.leger@bootlin.com>
>> Signed-off-by: Clement Leger <clement.leger@bootlin.com>
>> Co-developed-by: Guillaume Thouvenin <gthouvenin@kalray.eu>
>> Signed-off-by: Guillaume Thouvenin <gthouvenin@kalray.eu>
>> Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
>> ---
>>  Documentation/kvx/kvx-exceptions.txt | 246 ++++++++++++++++++++++++
>>  Documentation/kvx/kvx-iommu.txt      | 183 ++++++++++++++++++
>>  Documentation/kvx/kvx-mmu.txt        | 272 +++++++++++++++++++++++++++
>>  Documentation/kvx/kvx-smp.txt        |  36 ++++
>>  Documentation/kvx/kvx.txt            | 268 ++++++++++++++++++++++++++
>>  5 files changed, 1005 insertions(+)
>>  create mode 100644 Documentation/kvx/kvx-exceptions.txt
>>  create mode 100644 Documentation/kvx/kvx-iommu.txt
>>  create mode 100644 Documentation/kvx/kvx-mmu.txt
>>  create mode 100644 Documentation/kvx/kvx-smp.txt
>>  create mode 100644 Documentation/kvx/kvx.txt
>
>Please write this documentation in the RST format (you're 95% of the way
>there now) and incorporate into the kernel docs build.

Here is the polished documentation in reST format. Yann, can you please
squash this series into your documentation patch?

Bagas Sanjaya (8):
  Documentation: kvx: Convert to reST
  Documentation: kvx: Wrap diagrams in literal code block
  Documentation: kvx: Fix lists
  Documentation: kvx: kvx-iommu: Use reST syntax for subsections
  Documentation: kvx: kvx-iommu: monospacize kvx iommu device tree path
  Documentation: kvx: Promote title headings
  Documentation: kvx: Use literal code block for command-line inputs
  Documentation: kvx: reword

 Documentation/arch.rst               |   1 +
 Documentation/kvx/index.rst          |  12 ++
 Documentation/kvx/kvx-exceptions.rst | 258 +++++++++++++++++++++++
 Documentation/kvx/kvx-exceptions.txt | 246 ----------------------
 Documentation/kvx/kvx-iommu.rst      | 188 +++++++++++++++++
 Documentation/kvx/kvx-iommu.txt      | 183 -----------------
 Documentation/kvx/kvx-mmu.rst        | 294 +++++++++++++++++++++++++++
 Documentation/kvx/kvx-mmu.txt        | 272 -------------------------
 Documentation/kvx/kvx-smp.rst        |  36 ++++
 Documentation/kvx/kvx-smp.txt        |  36 ----
 Documentation/kvx/kvx.rst            | 269 ++++++++++++++++++++++++
 Documentation/kvx/kvx.txt            | 268 ------------------------
 12 files changed, 1058 insertions(+), 1005 deletions(-)
 create mode 100644 Documentation/kvx/index.rst
 create mode 100644 Documentation/kvx/kvx-exceptions.rst
 delete mode 100644 Documentation/kvx/kvx-exceptions.txt
 create mode 100644 Documentation/kvx/kvx-iommu.rst
 delete mode 100644 Documentation/kvx/kvx-iommu.txt
 create mode 100644 Documentation/kvx/kvx-mmu.rst
 delete mode 100644 Documentation/kvx/kvx-mmu.txt
 create mode 100644 Documentation/kvx/kvx-smp.rst
 delete mode 100644 Documentation/kvx/kvx-smp.txt
 create mode 100644 Documentation/kvx/kvx.rst
 delete mode 100644 Documentation/kvx/kvx.txt

-- 
An old man doll... just what I always wanted! - Clara

