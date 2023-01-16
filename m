Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9566766CF80
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 20:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbjAPTYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 14:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbjAPTYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 14:24:21 -0500
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF475222F3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 11:24:19 -0800 (PST)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-15b9c93848dso21543601fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 11:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=student.cerritos.edu; s=google;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QHWqzxyxlTNOWHFkW2+VYuevstHFo1/83nMqxdyHdC8=;
        b=BlISfV4JEoeAfSlqPwJ6wSzaQtFIZtsrUyGP4CxZKs5cOt8eRjXqLtyt4I0R+8fR+I
         BkuZv5DFeDAtj+ZJVl4jGgPAwzezdskIOP6mW9CB4oG+yUYhYg5Xx/1gVE+eVVpY9ssp
         UmkjErm2YV/PQgNBC4bHbZNbXLOGBXxVekznk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QHWqzxyxlTNOWHFkW2+VYuevstHFo1/83nMqxdyHdC8=;
        b=YQQBkegN88YG/X3OpVt4MC7DLN3ltMZPABP4zgq5IHu97Ml8lB2fnwikWo+RjrUcD9
         RS/obtiaxh3Y2ksc9ijdf4TiSfIFCWb83IwFf9dHpf+M9N2jERDs3q5cuY0cd/04HB5R
         v4JfS3umx6zsFcOndc57Cqw3/Y8BCZ/SiiQa8SJ0RiopaGEWMLlp1CYfkyWbaLokLM+h
         NvpcPwl412j23wEqE3lXHlMYpfpZiXwoe4JVx+0XU8PFFjy5Md95B6T+GoNclXrZ9542
         Py7bjjJXvcP00JUN9aShA6jUPBE8dwbm+XmzacY/28cFjXmNzLortHiSVIFA04ewDb/v
         WEMw==
X-Gm-Message-State: AFqh2kr7WaglyFFp1mt61M3fiqkcxBJ6v2lAc9EMKStUF2vgJ9euh5GX
        aF3XW5yrZLXEIV7+kURBW+yPxUiBSxMkgm10WO3CnChSOynHBg==
X-Google-Smtp-Source: AMrXdXvRJDNGC3+PUm+dvMuPD/j3rDWS0gf3kSrGAdreW2GIZXPohPQbVD+9bhLgpFtr65Y4AmqNgEqGFN3lUg6GeOU=
X-Received: by 2002:a05:6870:f81b:b0:148:1c00:ce8c with SMTP id
 fr27-20020a056870f81b00b001481c00ce8cmr69936oab.296.1673897058779; Mon, 16
 Jan 2023 11:24:18 -0800 (PST)
MIME-Version: 1.0
From:   Amy Parker <apark0006@student.cerritos.edu>
Date:   Mon, 16 Jan 2023 11:24:19 -0800
Message-ID: <CAPOgqxFva=tOuh1UitCSN38+28q3BNXKq19rEsVNPRzRqKqZ+g@mail.gmail.com>
Subject: Kernel builds now failing
To:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_20,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SPF_PERMERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of recent, my kernel builds have started failing. The error is consistently:

find: 'standard output': Broken pipe
find: write error
make[2]: *** [kernel/Makefile:157: kernel/kheaders_data.tar.xz] Error 127
make[1]: *** [scripts/Makefile.build:504: kernel] Error 2

This fails on the default Arch configuration (6.1.5-arch2-1, defaults
for all new features) as well as with allmodconfig.

Everything was building fine before - this may be a regression, or
just may be a problem with something in my toolchain updating and
causing it to break. In that case, any assistance with getting my
toolchains back to being able to compile would be appreciated.

Amy Parker
she/her/hers
