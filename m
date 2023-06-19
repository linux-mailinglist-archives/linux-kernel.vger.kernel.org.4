Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D8F736046
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 01:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjFSX4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 19:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjFSX4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 19:56:00 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BDB10C
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 16:55:59 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso3335320a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 16:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687218959; x=1689810959;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PVs4GZ+Uk0ye5HivrV52qoVsAKrFnxtINai6WrA4s10=;
        b=bnsaeUByEcXlvYMyc0xWRsGsq5X5KsQgHfS2Q8HQkhML7cQ+TQpwPamDechTjs34uH
         qjhluw+hW1+E3Bc0w5iBO2iBQqzLeU9/EGZjdKW5pxEPHhdlKfRRGomEwBdixLX4cl7t
         /fy8OSmL/rTd06qUB83TXKOk4Ut56Gj0HopDxZczzm7hmAXBpoKh3/QCjMeZNfFqNFYJ
         nB/QN3p14jrPE06jxdBl+QItEcVdC5eoF0eKuRC+PFFDpIHypISY5uZ6ABDBSnIMgs4D
         78EbUKJ9aORJDEo8cOpl8gkPK10Xr987b1iVXfW89v0fCFKoIoPiqOoHKfQPvuwdov7Q
         A83w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687218959; x=1689810959;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVs4GZ+Uk0ye5HivrV52qoVsAKrFnxtINai6WrA4s10=;
        b=U9oKuKLiVQY1Fa8zvqWXQYONi+vwNZCx1FClEmGqiurzg+S1C5mbYj8c+cXdO0XKoa
         gEpD1y50jzBp9h83ccmLlc/8zQ7guzkBNuXDJBEpbWG9rB/KPw5s8V68LyHO9KqQ4ZGR
         Sl/hhQSy/T8HfcXOJ6ZvhroNAYpE7KFr7d2mTblqi8odY+7dJlZjGE9xojZwXPN/qk9e
         udZa9S3qfmR1bXXCQOAWSAUECE8MQPKIeLSPh5WRK9qaFg8Lls6KW+RdtgSI7AREUcms
         TUbYm975FdAgF0X9y5USALeBkO9SOnSIgFlYzkfgY1xQ2Y/QGhfWaStH9qpCuNwGiknE
         dXzQ==
X-Gm-Message-State: AC+VfDxXSqRMMT4NTt3Inlf+DeI9BcFjHxVj6+rV9IxVQIuWF9VYcjmN
        5DKMwIlxnTpvqV9XZhs/3JKW6Q==
X-Google-Smtp-Source: ACHHUZ7H4bBeRtg5noFSyoSmqZBkjh8GrAu4Bc58BQ9WL/NTPzK1axTjkkcFFvOw/eLdBjnQiPhdmw==
X-Received: by 2002:a17:90b:1202:b0:25e:a1c7:3a73 with SMTP id gl2-20020a17090b120200b0025ea1c73a73mr10645969pjb.2.1687218958757;
        Mon, 19 Jun 2023 16:55:58 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id gz10-20020a17090b0eca00b00256b67208b1sm6140575pjb.56.2023.06.19.16.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 16:55:58 -0700 (PDT)
Date:   Mon, 19 Jun 2023 16:55:58 -0700 (PDT)
X-Google-Original-Date: Mon, 19 Jun 2023 09:54:21 PDT (-0700)
Subject:     Re: [PATCH v2 3/3] RISC-V: hwprobe: Expose Zba, Zbb, and Zbs
In-Reply-To: <2605015.k3LOHGUjKi@diego>
CC:     linux-riscv@lists.infradead.org, Evan Green <evan@rivosinc.com>,
        ajones@ventanamicro.com, aou@eecs.berkeley.edu,
        abrestic@rivosinc.com, coelacanthus@outlook.com,
        Conor Dooley <conor.dooley@microchip.com>, corbet@lwn.net,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Evan Green <evan@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     heiko@sntech.de
Message-ID: <mhng-92d5d02a-ccb5-497c-b8ea-c57709b3df5f@palmer-ri-x1c9>
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

On Wed, 10 May 2023 07:47:54 PDT (-0700), heiko@sntech.de wrote:
> Am Dienstag, 9. Mai 2023, 20:25:03 CEST schrieb Evan Green:
>> Add two new bits to the IMA_EXT_0 key for ZBA, ZBB, and ZBS extensions.
>> These are accurately reported per CPU.
>>
>> Signed-off-by: Evan Green <evan@rivosinc.com>
>> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
>
> Reviewed-by: Heiko Stuebner <heiko.stuebner@vrull.eu>

This one too.

> though a part of me wonders, what happened to Zbc ;-)

I think we all just keep forgetting about it as this round of HW has 
missed out on it.  If you care enough to send a patch I'm happy to pick 
it up ;)
