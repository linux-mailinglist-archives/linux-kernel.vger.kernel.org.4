Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954C6665274
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 04:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbjAKDmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 22:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjAKDma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 22:42:30 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAA82B1;
        Tue, 10 Jan 2023 19:42:30 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id v23so14524205pju.3;
        Tue, 10 Jan 2023 19:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4n5QZy7g/1aDMvcFC/CDd1ADRJ2ZCV2H96hKEjp2Tt0=;
        b=G/9WxcZwcHj82j+8ORnJb2+YWLi0gZQ2OIcaNA+0yq9/htNrwEC8Kg2Yhkw0EEdX0I
         8XC/CXjXunp1ThVdZSIpwuuA9UyMNSHC0uruVUNbgjucqQpeqFcGTXG7wLK9mjn9GgeZ
         +WeEIU45xxstA7U/eYp6paXW9tJ5UHKhD+/GWNIMHAdSrUh+kvL7Xh2u8TbASbMfHXRV
         tI+pPZxqZ0zdJwoEWZ5WPVpL2dDh7O+jpF4bcAxUIqgeUYX/ewVgBoI+zuTra2cBc2rQ
         7SZ0v7PzzrXBNvYapavcYvYSw0yxwrPb2LZzIO1HBekg3CdFY0309jjCvltNLu2zXNAD
         tIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4n5QZy7g/1aDMvcFC/CDd1ADRJ2ZCV2H96hKEjp2Tt0=;
        b=wTN0HvA8LqgVV3+giHS3L5iPqo/Dmpn9s5vzZeDx/VVwamtJSKK8OUU/dVY447Behb
         ei3uyOkynwC9Qy5OcrDQ6d8mWWidURe3XIkISh9JIQDU8MQt0UkSxFstTCyoqQXIyBro
         VG1kAn6mACKMWEG6cwlT4+CNIffzw19xGcKGMo6GF8RC+hzi4aJ8EZk8aR/+VaYlX/W8
         VgrMFDQZ6sZEjOO2DKUF0ai7YA2xxdppmtrTJ2IhY7jbLvDNsZ+MOtTD24A8fg4tl1eR
         kTImWpfo2HabmC0C/qpnqStd56zz+I+Vo0/3BgrQLVS5suoFJPc88v++NpY/Iv+jVN1v
         On4w==
X-Gm-Message-State: AFqh2kqdSxUjpj0bBAB0BZ7uKsdmmXRxzjlBApaWkwJRwjHeCND29Dw9
        HbIyjUQfX+2HAi/4qUP5Zsk=
X-Google-Smtp-Source: AMrXdXvMM0hDGpPcpa3dadoUPn2d83HTpWr6n7dyfx/M6PGJCp2b/DqdSExEKoIWPHpyrawPvPpn2g==
X-Received: by 2002:a17:902:ccc4:b0:186:e434:6265 with SMTP id z4-20020a170902ccc400b00186e4346265mr84653045ple.2.1673408549347;
        Tue, 10 Jan 2023 19:42:29 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:3f43:2598:9756:e3b])
        by smtp.gmail.com with ESMTPSA id ik9-20020a170902ab0900b00183c67844aesm8883541plb.22.2023.01.10.19.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 19:42:28 -0800 (PST)
Date:   Tue, 10 Jan 2023 19:42:25 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Werner Sembach <wse@tuxedocomputers.com>
Cc:     hdegoede@redhat.com, mkorpershoek@baylibre.com,
        chenhuacai@kernel.org, tiwai@suse.de,
        wsa+renesas@sang-engineering.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: i8042 - add Clevo PCX0DX to i8042 quirk table
Message-ID: <Y74wIRrzalT5bJvt@google.com>
References: <20230110134524.553620-1-wse@tuxedocomputers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110134524.553620-1-wse@tuxedocomputers.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 02:45:24PM +0100, Werner Sembach wrote:
> The Clevo PCX0DX/TUXEDO XP1511, need quirks for the keyboard to not be
> occasionally unresponsive after resume.
> 
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> Cc: stable@vger.kernel.org

Applied, thank you.

-- 
Dmitry
