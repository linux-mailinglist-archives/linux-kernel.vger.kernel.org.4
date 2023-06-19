Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21AA4735065
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 11:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjFSJex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 05:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbjFSJd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 05:33:58 -0400
Received: from hi1smtp01.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6240183;
        Mon, 19 Jun 2023 02:32:35 -0700 (PDT)
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
        by hi1smtp01.de.adit-jv.com (Postfix) with ESMTP id 183155202EC;
        Mon, 19 Jun 2023 11:32:34 +0200 (CEST)
Received: from lxhi-065 (10.72.94.24) by hi2exch02.adit-jv.com (10.72.92.28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.23; Mon, 19 Jun
 2023 11:32:33 +0200
Date:   Mon, 19 Jun 2023 11:32:33 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
CC:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH] kbuild: make clean rule robust against too long argument
 error
Message-ID: <20230619093233.GB20014@lxhi-065>
References: <20230617153025.1653851-1-masahiroy@kernel.org>
 <20230617200700.GA31221@lxhi-065>
 <CAK7LNATbrP4Re+-9rY9d0=Dsk-O4DasZZtV0wM7SWg3Y5eLKmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNATbrP4Re+-9rY9d0=Dsk-O4DasZZtV0wM7SWg3Y5eLKmQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.72.94.24]
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Yamada-san,

On Mon, Jun 19, 2023 at 12:50:48AM +0900, Masahiro Yamada wrote:
> On Sun, Jun 18, 2023 at 5:07 AM Eugeniu Rosca <erosca@de.adit-jv.com> wrote:

[snip]

> > Please, correct me if I am wrong, but it looks like the magic/brilliance
> > is in the 'patsubst' function, since below version also fails for me:
> >
> > NOK: cmd_clean = printf '%s ' $(__clean-files) | xargs rm -rf
> 
> Right.
> Now, 'printf' (instead of 'rm') failed with the too long argument list.
> 
> GNU Make does not have the length limit, but shell does.
> So, the full-path list must be passed via stdout
> instead of the command line.
> 
> 
> The comment might be confusing.
> 
> I will repeat the same comment written in scripts/Makefile.build:
> 
>   # To make this rule robust against "Argument list too long" error,
>   # remove $(obj)/ prefix, and restore it by a shell command.

Sounds good to me. No open questions from my end :)

-- 
Best regards,
Eugeniu Rosca
