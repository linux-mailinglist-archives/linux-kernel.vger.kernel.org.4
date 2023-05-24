Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA24710033
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 23:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236117AbjEXVxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 17:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjEXVxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 17:53:11 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25588122
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 14:53:10 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-96f850b32caso265436166b.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 14:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684965188; x=1687557188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GmM3xzgdi9y49uPixr7wck0B/tHNIYgDgFJoqWzjkEA=;
        b=bVqxREpK+03YND31Jh4cEDFPgL8FpJW9NnFeb5mMkzhklvbtJwbW1wbr9S5aL3GkJy
         Q6jN5x7OX/eP3Vgzcn4H7I7rJd6gqAcvyDKnnba9AaTQLQy8xlESHq9txuYPGC922HHS
         LaTgptjCKBFG1TmYlmHJcUMn2OfDQnw8+DJRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684965188; x=1687557188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GmM3xzgdi9y49uPixr7wck0B/tHNIYgDgFJoqWzjkEA=;
        b=JAtwrVc8pGi74+7iYbgBJlgMKUxFfYrzoZ8A65iSVCkZwPuBfOIKM4USB3ekY3IgMr
         yngoCjuoRL6N5R/+ADUJV1JXjTsEIL25GAD4VubrDH64gH4j9lv+t/bb0T+Xlk4Zov5R
         pPkbTcS+5VrEK5/tQYCkUn9yidDlmKM17F9Lbq16THEHa5ILPYnFU10WD79caaikVPcO
         RqLI3Uy7mOnarzibZAfjiLDdeypD2Ou2TCV12QbcBoettJRDyivWLCJi0ye3kqASi5O2
         zhaGlU1pNyD3xPHnehiwU1DEBTrWDSdXV/N/NN/+FsFGFUvrxcM0fWlGrF90SuyuMvtk
         u5iQ==
X-Gm-Message-State: AC+VfDwcGJgPhiNUAp+QndHeAncr4h5PqY0rSaVimQbBgCF4dIannz6i
        23eLMestA4rV532+34HeE5eoVp2jVl1U5H+bnddVrQpU
X-Google-Smtp-Source: ACHHUZ5KTJitM6CUu16RvvnkNNPbIVXukI/IR522NBo2C+4XVujQwCPHTB/5qh5g6zRg+fZBpPsIUQ==
X-Received: by 2002:a17:907:9688:b0:96f:7af5:9e9e with SMTP id hd8-20020a170907968800b0096f7af59e9emr20518017ejc.53.1684965188468;
        Wed, 24 May 2023 14:53:08 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id s12-20020a170906168c00b0096165b2703asm6240902ejd.110.2023.05.24.14.53.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 14:53:07 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-510d92184faso3064057a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 14:53:07 -0700 (PDT)
X-Received: by 2002:a17:907:8a12:b0:93e:fa12:aa1a with SMTP id
 sc18-20020a1709078a1200b0093efa12aa1amr19427794ejc.1.1684965187067; Wed, 24
 May 2023 14:53:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230524213620.3509138-1-mcgrof@kernel.org> <20230524213620.3509138-2-mcgrof@kernel.org>
In-Reply-To: <20230524213620.3509138-2-mcgrof@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 May 2023 14:52:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjahcAqLYm0ijcAVcPcQAz-UUuJ3Ubx4GzP_SJAupf=qQ@mail.gmail.com>
Message-ID: <CAHk-=wjahcAqLYm0ijcAVcPcQAz-UUuJ3Ubx4GzP_SJAupf=qQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs/kernel_read_file: add support for duplicate detection
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     david@redhat.com, tglx@linutronix.de, hch@lst.de,
        patches@lists.linux.dev, linux-modules@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com, lennart@poettering.net,
        gregkh@linuxfoundation.org, rafael@kernel.org, song@kernel.org,
        lucas.de.marchi@gmail.com, lucas.demarchi@intel.com,
        christophe.leroy@csgroup.eu, peterz@infradead.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com, yujie.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 2:36=E2=80=AFPM Luis Chamberlain <mcgrof@kernel.org=
> wrote:
>
> Add support for a new call which allows to detect duplicate requests
> for each inode passed.

No.

This is all disgusting.

Stop adding horrific code for some made-up load that isn't real.

           Linus
