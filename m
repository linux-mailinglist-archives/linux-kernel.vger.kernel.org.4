Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67AC76E339E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 22:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjDOUlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 16:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjDOUk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 16:40:59 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C048E5
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 13:40:58 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-3e699254ac4so8634431cf.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 13:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1681591258; x=1684183258;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5ZpJOS2H9PgGp4Q72WdTfSs9gPQF5dEYfpY40h9OUQ=;
        b=UzU//76cztdU1LgexNLanS+PonvEY1gfbmf2XiwBHWabM0B+HR+5mkKYMsJklwCCn/
         D5bcRCSYS143FhZdjgcNigSfttd9A+nUNaSO8oI9FcIbEQcL+e5M6JLXwQJ36h5j4cWw
         9Y87Z871/OiG5GP0uPnJxCGb0J1Q3je9mvsT5eLZICyaQaXJFk38RCH6wZI6fMyCoA03
         ig/CUVoT4ZH8CnNByrhBkIojoU+mZC+T/3OV1nMOMHShB6czLciDHtzBzG6WajheDuS0
         mpGwt9J6iuTLkiRY8Nv8/67dpQ4L1Q51NpHQLMMqBDZGgRUPlFtGugqsj/pi8PLZ9Rgm
         NeTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681591258; x=1684183258;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K5ZpJOS2H9PgGp4Q72WdTfSs9gPQF5dEYfpY40h9OUQ=;
        b=BdUYJVthqd4F5aqJ3ABVZ098H2zrNudYGjvJ6YG12Q5SSbDvCEb3zoJ7BYfpbajoA/
         vWUG1nQGLVzxd2rcGBSbBrgCx56UlM5NHKTY5DUi7+NRWqA4iw8uwCOKOhQKfSPNrWD3
         rXgHit86yua3C9V/sWnMz2ic7e4hZgRhYnWBQ9B584Y+ZeBz5QKmaV24cs8e5jImK3k+
         DBZDEP5OcLGi1rA5mbMnjJuZKecQ9fu/6bpKIcVB5YhQQRaHHXXEF6Oj+x/HCHnpLfcs
         1Q0yc/nD3vfEp3fZYaK7peTdlvY+wamoeTNv8cdkh2NRjOstambnhK69yhNiNJLxuVCw
         J3bg==
X-Gm-Message-State: AAQBX9ekAiVAu9a+BarXE6axozLlQaOjbuAVoej3ZSDLfYrzSja++VcX
        wvnC8lOcHzYr4v74d1rTN3Uazg==
X-Google-Smtp-Source: AKy350b7Jgq/iFYYGf1L3SXkiJAspR6o8DYiL85urxLnUkV+LsBU0p8W38LeUr7ZJa9KfcGW8yLuuw==
X-Received: by 2002:a05:6214:3011:b0:5ef:5132:7ad7 with SMTP id ke17-20020a056214301100b005ef51327ad7mr9930130qvb.2.1681591257782;
        Sat, 15 Apr 2023 13:40:57 -0700 (PDT)
Received: from [127.0.0.1] ([216.250.210.6])
        by smtp.gmail.com with ESMTPSA id pp26-20020a056214139a00b005dd8b934571sm1996244qvb.9.2023.04.15.13.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 13:40:57 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     lkp@intel.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Akinobu Mita <akinobu.mita@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, shinichiro.kawasaki@wdc.com,
        chaitanyak@nvidia.com, akpm@linux-foundation.org, hch@infradead.org
In-Reply-To: <20230415125705.180426-1-akinobu.mita@gmail.com>
References: <202304150025.K0hczLR4-lkp@intel.com>
 <20230415125705.180426-1-akinobu.mita@gmail.com>
Subject: Re: [PATCH -block] fault-inject: fix build error when
 FAULT_INJECTION_CONFIGFS=y and CONFIGFS_FS=m
Message-Id: <168159125392.9478.18069985091201670556.b4-ty@kernel.dk>
Date:   Sat, 15 Apr 2023 14:40:53 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 15 Apr 2023 21:57:05 +0900, Akinobu Mita wrote:
> This fixes a build error when CONFIG_FAULT_INJECTION_CONFIGFS=y and
> CONFIG_CONFIGFS_FS=m.
> 
> Since the fault-injection library cannot built as a module, avoid building
> configfs as a module.
> 
> 
> [...]

Applied, thanks!

[1/1] fault-inject: fix build error when FAULT_INJECTION_CONFIGFS=y and CONFIGFS_FS=m
      commit: 5347c9321845e5a94be19ea951746d4f2b8b194f

Best regards,
-- 
Jens Axboe



