Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B5160259B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 09:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiJRHWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 03:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiJRHWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 03:22:23 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED14AB83B
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 00:22:22 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d10so13296881pfh.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 00:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmmQqngBHRO64jwJHlH4N8QJ8HHeFfHjYmmW2fvTNrE=;
        b=mKyGm3XbRd8gH9cVGki2o1JHhGdcCBGN+sKVLSvL4QrvYRZrmNHYVkn3fPf6/zZbF8
         3dSuHMcZ+u5twLyXF1CCYNKe93YlLTLAJr+tQ0ddx8gVLJAzLDG/4hzDsZ5jEJNG/4v/
         +BCij7wsdF/uu9G2B0LiZv2OE9AF28ixq1SWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zmmQqngBHRO64jwJHlH4N8QJ8HHeFfHjYmmW2fvTNrE=;
        b=JTxZMxWzvTRtXcTTO/4b8bDT14cAs1ZiphPPJUIVVAwUjRCZJdHdRQOu5nGV3u7HrY
         Ycg1tuYYZvjr1qlSwBdy34yRQU10Piuk7sKKq3NoNr+qTsOv4mQE7fTbd8HaANAn68+j
         nhKvxy8o32SG9nPnPvIrMsBCiPD9T4r7Q1l5GS4dCsba7eIq4aenoTmY4Su9mkB0EvuC
         viNqZS/Iw0/zyFJGdJDyF7DEuPkAj8kBcL2QoZX8+bF84oIZfYFxtyYaWVX05ylNn8Ip
         5p0erl40+YAIk0/ZAL1Ii97hcJcvRgXtlRjZCEAGvY2v/uZrPeABA5HUUREpYAD2UE10
         RnBw==
X-Gm-Message-State: ACrzQf1vENGBwTz9wmlbEH7gBaJkvnBv7p87rzlte4VeeP+IdnRJ1H26
        vZAnBxzWrXo+uVNuL+dja5DZmQ==
X-Google-Smtp-Source: AMsMyM7sSHggHqyJ0TcgW9+BkVyaT7rEgzYrT/GyJ+YeoRMLr8q0Oj65cetn/KVqd9ihtHbeu0I/ww==
X-Received: by 2002:a05:6a00:13a3:b0:563:6d36:ba58 with SMTP id t35-20020a056a0013a300b005636d36ba58mr1576650pfg.43.1666077742371;
        Tue, 18 Oct 2022 00:22:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z8-20020a1709027e8800b00178af82a000sm7864182pla.122.2022.10.18.00.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 00:22:21 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, ebiederm@xmission.com,
        bernd.edlinger@hotmail.de
Cc:     Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] exec: Copy oldsighand->action under spin-lock
Date:   Tue, 18 Oct 2022 00:22:06 -0700
Message-Id: <166607772207.3775126.2855869252440923728.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <AM8PR10MB470871DEBD1DED081F9CC391E4389@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
References: <AM8PR10MB470871DEBD1DED081F9CC391E4389@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jun 2021 15:54:27 +0200, Bernd Edlinger wrote:
> unshare_sighand should only access oldsighand->action
> while holding oldsighand->siglock, to make sure that
> newsighand->action is in a consistent state.

Applied to for-next/execve, thanks!

[1/1] exec: Copy oldsighand->action under spin-lock
      https://git.kernel.org/kees/c/f53283b0165f

-- 
Kees Cook

