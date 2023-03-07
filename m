Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D796AE735
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjCGQt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:49:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjCGQtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:49:07 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE10C90B4D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 08:45:21 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id me6-20020a17090b17c600b0023816b0c7ceso17138621pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 08:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678207521;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4F8gpjDoT3xNy3Qvl/wLkY5/N3k6H9FAAlC8tegJRMg=;
        b=IQ4KFU8wM+Rqah+cboOqSKl+U/jM8agWUmucajCdme/QLHkVNQXf73Jgwv7tDWM1yD
         VZ+oZYEzGPHInJHveDz7yQFeGMW3yU1EN/f9SBJSzfHRt3QiITp9n0RjPpaRx2idpS7C
         WdlDhvZG/cQ7K69ZhZnDw8VsDBZHzR+11NeTZpOtOnOBxd+c5rvxFfmL5hzRsZRUcN1t
         ty/VaRH/uq2qWIcWHZeQ+KvApTi2vK9WgQU03IEuUa+/p+5H5kP/qirpPyNa4zx7Vyxv
         lCI34WDUhCRb8lPF86RQkLT6A31qEue3jz6cGOedh7G5ThzIlXBzh32HDPud66HATBkz
         ZejA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678207521;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4F8gpjDoT3xNy3Qvl/wLkY5/N3k6H9FAAlC8tegJRMg=;
        b=QBTW1yAe1oo3dFQdclX7nG37QiF+3Pu7erWc1Gg8QUv/WCWxP9ou3GCHFZbjR4SOI4
         CCeWI29jvtobgwWdZ6cLTTToRZCqGFMtaIfpH85TiS2GKrCxULif/GzimeoDfnud/WdF
         zZcBLox6HpnassDdZ7BvLIuWV/t2TRjfsjRoJNCC1d/itzfOg2IEFX5yy47dVzv/6PZw
         lmfDMskuw5WuafdJOiBNrlrsFcLEVSsyCJiaHqJyDTOf7eBr2aKgIfHZkwC43SherxX/
         M/YmcApHbSfAqXuMbKh1sDd8BfAmdhRwrfjzim28FS2ya6UiHFX6A1DE35KZJcpdS8+L
         8NjA==
X-Gm-Message-State: AO0yUKWDSD/sRJpCfsbvkhwBUnig/Co3tDbCPvWgxpbxsakyZaeSgHxW
        aFqADR7xwZgPAWN7fzwZeJo=
X-Google-Smtp-Source: AK7set+8wHZJLIImgkWkf6FdpWY+4jxIEMQlterWqs0VbXnAPJwy1i/5DOO/9epxJFT25Infm/uuVQ==
X-Received: by 2002:a17:902:db02:b0:19c:edcd:26cf with SMTP id m2-20020a170902db0200b0019cedcd26cfmr15118652plx.61.1678207521111;
        Tue, 07 Mar 2023 08:45:21 -0800 (PST)
Received: from thinkstation.cmpxchg8b.net ([76.133.164.192])
        by smtp.gmail.com with ESMTPSA id s5-20020a170902988500b0019a6d3851afsm7039787plp.141.2023.03.07.08.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 08:45:20 -0800 (PST)
Date:   Tue, 7 Mar 2023 08:45:19 -0800
From:   Tavis Ormandy <taviso@gmail.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Alexander Monakov <amonakov@ispras.ru>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: x86: AMD Zen2 ymm registers rolling back
Message-ID: <ZAdqHwqik9kP5ELs@thinkstation.cmpxchg8b.net>
References: <Y/Xp73KJe3c/1jrn@zn.tnic>
 <4737f149-c5b7-8a51-7cc5-8bda6e98308b@ispras.ru>
 <Y/5T4ScbM/99DhgT@zn.tnic>
 <3d007f98-a42a-3c0e-8d6a-c86c5d0e25be@ispras.ru>
 <Y/5VIECduoyCJKP5@zn.tnic>
 <4d21fe93-7b77-bf5a-9ba8-645256ab0983@ispras.ru>
 <Y/5qbJgwHhkrMQqr@zn.tnic>
 <7ce3ea01-9758-0a97-e810-2bf38e7d59a7@ispras.ru>
 <2eccf8e2-4aa3-dcda-064d-ca39d2295548@citrix.com>
 <Y/8StpL8atNwyzip@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/8StpL8atNwyzip@zn.tnic>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 09:54:14AM +0100, Borislav Petkov wrote:
> On Wed, Mar 01, 2023 at 12:23:01AM +0000, Andrew Cooper wrote:
> > So we need a table for all Zen2 parts of ucode revisions below which we
> > force hide XSAVES as the erratum workaround.
> 
> Working on it - stay tuned.
> 

FYI, I heard from someone offlist that they can reproduce with the
latest microcode available on this cpu:

cpu family  : 23
model       : 17
model name  : AMD Ryzen 3 2200G with Radeon Vega Graphics
stepping    : 0
microcode   : 0x8101016

It seems likely many zen1 systems are affected without any microcode
patch, which seems not great to me.

I guess it would be nice if AMD could provide a list of devices they're
not going to provide a patch for...

Tavis.

-- 
 _o)            $ lynx lock.cmpxchg8b.com
 /\\  _o)  _o)  $ finger taviso@sdf.org
_\_V _( ) _( )  @taviso
