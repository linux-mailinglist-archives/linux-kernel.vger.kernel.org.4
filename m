Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2100F705D94
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 04:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbjEQC5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 22:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbjEQC5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 22:57:48 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960072705;
        Tue, 16 May 2023 19:57:44 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-643990c5373so200834b3a.1;
        Tue, 16 May 2023 19:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684292264; x=1686884264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8hhWsXrhhZhUyOAd+do84J/5IkDaxDP38fgUKTDS9po=;
        b=I0nd20kpV5l6NQNhNgzvawU9SA6riyj1/DSyTP0RDTDFlY/UAKsR/upbbc9q3zMksh
         Kmisjoji5bAxbawPtyXcrQY4ITobRdK9HzK06Yb000+cda/RkGrDED0PSG9Leef6Lxgp
         yz+d59u/lggvkb5+Z2aDdnnZKfwXqxOdFVFD/pQwqxYzlg86yx23w9N9vz/lP0JlQZkR
         k4nx9OZhM3WWil6JYK7uWAx1aJszmNfumz3EDhGZ8nM+IenyLfEWwkil1LB0SPIoWDto
         LD4EFn7GTmCwjBAa9znkZkiWDtwRqjIOsFsfjFGzxni1jASeHKTIRA6EYpfR4azhiFh/
         P49w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684292264; x=1686884264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8hhWsXrhhZhUyOAd+do84J/5IkDaxDP38fgUKTDS9po=;
        b=avgf2epn0dEcHAOD7cZnYvoH+CJpHUkE0h+519L1KnnFxIcZdinW/a+ElaL0CZY7Wt
         R4J8HvuKisE2ft9KWTpaU/2odPMxLDGJAhFhjXLMc+AtxnD5T/0k1dVQIRcMYbJeZ3FV
         OGpl4IIgHBX7arPfphtAXzrP0ioKzfoTWeHsWAcKTmyq5v1MBJO9GDxKdI5WoLb3ljAk
         Y21Smocqzh1oxqV2CUtOpmCynA9EJ9fA6/R9Ot0AAKpXPLF0KbuZij6w0gVsP5H0OT/t
         cZw22MlYoYLEY4O77DrdmOFZD2ZtywB1RtQQttG7EIRXX4xHyKACvg71LZFXvMiXJU4v
         mw2w==
X-Gm-Message-State: AC+VfDy9okIDKeftUgbDVWLymCwlDcHV9G2u1HGuaE11BUBSAwcQZy+/
        nGq8yi8BN8OsTcjabTM3ScA=
X-Google-Smtp-Source: ACHHUZ4SkYvhKzyOuwuMkeSAGtRizlHOIh7L633LB33QjkzLke1sBtx0dyY6basPkaFBJBD5rsiPaQ==
X-Received: by 2002:a05:6a20:3d09:b0:100:5f62:be76 with SMTP id y9-20020a056a203d0900b001005f62be76mr43080303pzi.54.1684292264065;
        Tue, 16 May 2023 19:57:44 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r15-20020a170903020f00b001a1a8e98e93sm16265340plh.287.2023.05.16.19.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 19:57:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 16 May 2023 19:57:42 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 5.15 000/134] 5.15.112-rc1 review
Message-ID: <a56446b6-ce5e-407d-acaf-94e7680a89b0@roeck-us.net>
References: <20230515161702.887638251@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515161702.887638251@linuxfoundation.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 06:27:57PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.112 release.
> There are 134 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 17 May 2023 16:16:37 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 160 pass: 160 fail: 0
Qemu test results:
	total: 499 pass: 499 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
