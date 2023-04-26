Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C647A6EF9BB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 20:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbjDZSBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 14:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbjDZSBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 14:01:17 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3808C618B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 11:01:15 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-63b5465fc13so5904893b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 11:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1682532074; x=1685124074;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c/AvOGvFjJZtRiTzQkto3Esn+bIc3Zq2R6q57+PVw+Q=;
        b=zQKXmf3WReCtx/hQXD1AMP3N0rPn0mT3owkWbY1kgGkCFXWeiVEBq415SA37Onj3nm
         G3ilcE3q3WzCzPQ4Y5P9Phqb412l44WqRjAAJXRzS8zkdjubFdPVHdIFIABzQ3UYWumG
         JBNwAKQlOMMxB+0W+MnluCQUT4vL/MoTIEsyd+JsYKIt+//ruimak0HJ1yFb+R1V6Jhg
         TxMLTYghRexf19s+RtMbDj+wMXRg28m8VZroqKGJiB/jHVTpOVmBCNLKozi2rcjhucN2
         de8MGHC6SvOLPiOMilXBWztHQ/TwB5gPoeMuoGvIDFTPHdEvfip6+GWk7yQVkr4Kcw/r
         Yt8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682532074; x=1685124074;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/AvOGvFjJZtRiTzQkto3Esn+bIc3Zq2R6q57+PVw+Q=;
        b=jsQRiBwrl32fFZ5dem8NkOEDH0Mj14V/uH+lB7XVtGuZ3VLTKdalyfIMX8uyQo7CNX
         lGuTVXicbMGDiABP0HY46Ze15Kb5L+AkzWCikcCNq9EQ+wlk9npcHsC4wnQyAovKI9II
         kdmBK5/dO3lOz6fztspfSqlPLtb8+AAV5AgYwGj985SbHc9fFGyf48KRDLAbcdEC5yuk
         vKrfieHsltiNxMm4UJnieZ4JteQg9vnwZMNyhgLd7lRgPS+dW7LOOEY5q27wLD4YIGTD
         hCJ9evRC1l/TfnH9C7SJ8eW6OUCIYe95mJzUarfC5s4tgQ1KxYM+OI47OwtcpJfUny5I
         HOuA==
X-Gm-Message-State: AAQBX9dFAF/k7daCKf5+ikeYfQjyvIs6q6BBZaBv3OoPGHgUz2o4avA3
        DBjyMGpXI7lR3/iQOoNVEHEONA==
X-Google-Smtp-Source: AKy350bmGfldtggaIFTdKiYkcB67Uuzs3JkDTN59pFUhhlPkYTX7BmvCymTKn87B2FoTzvQen+MlUA==
X-Received: by 2002:a05:6a00:2e0d:b0:63b:1708:10aa with SMTP id fc13-20020a056a002e0d00b0063b170810aamr30661317pfb.34.1682532074471;
        Wed, 26 Apr 2023 11:01:14 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id t3-20020a056a00138300b006338e0a9728sm11583929pfg.109.2023.04.26.11.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 11:01:13 -0700 (PDT)
Date:   Wed, 26 Apr 2023 11:01:13 -0700 (PDT)
X-Google-Original-Date: Wed, 26 Apr 2023 11:00:59 PDT (-0700)
Subject:     Re: [PATCH v6 00/13] Add OPTPROBES feature on RISCV
In-Reply-To: <14608847-C2F3-4C5A-9801-34DAC933E895@mails.ucas.ac.cn>
CC:     bjorn@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mingo@redhat.com,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        liaochang1@huawei.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     chenguokai17@mails.ucas.ac.cn
Message-ID: <mhng-00aab15d-560a-4d46-b6c7-ab11eb52a7a7@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jan 2023 06:38:42 PST (-0800), chenguokai17@mails.ucas.ac.cn wrote:
> Hi Björn,
>
>
>
>> 2023年1月30日 20:31，Björn Töpel <bjorn@kernel.org> 写道：
>>
>> Chen Guokai <chenguokai17@mails.ucas.ac.cn> writes:
>>
>>> Add jump optimization support for RISC-V.
>>
>> I'd like to take the series for a spin, but I'm having trouble applying
>> the the patches; What base commit did you use? Or point me to a git
>> repo.
>
> I generated this patch series based on next-20230127 tag
>
>>
>> (It's nice to use "--base" to git-format-patch.)
>
> I will take this parameter in any following revisions, thanks!

Just checking up on this one, it's got some feedback that seems 
reasonable.  Sorry if I missed the v7, but I'm dropping the v6 from 
patchwork.

If there's no v7 on the lists it's probably too late for 6.4, so no 
rush on my end.

Thanks!

>
>>
>>
>> Thanks!
>> Björn
