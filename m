Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB716B4AC3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 16:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234251AbjCJP0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 10:26:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234229AbjCJP0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 10:26:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E537129725;
        Fri, 10 Mar 2023 07:15:25 -0800 (PST)
Message-ID: <e89667d6-e65a-e9d8-5433-1cf918f6ff14@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678459793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WT6x5ALV9Avon1agL1/IFmPx2GHhD7TtkWqFlKSXWUk=;
        b=gmW/hah6lnrBAeb/26WYOxG2PLdNIOu0Q8pSZ7BFBbBhrmekFvAe1t8XGrqYNpIW3akqqI
        nfbSgEnHHUSjH3He8LUCqHTgouYpNHfpgof3ePS7ctW+fbZSFBG30HGcxjvXt4ZeXn+3od
        uMZeP+KDVxr6aPwfysKENJEwWA+DK/joc3At1+mh6BE8R3XfuqLlswX4OlffCVonxFLv1P
        YkJh+yFRpBRpi3AN+SGe2+Pa7adjljbTixyHbaY1dNkk0ujfgeIMszmnqzvFNKOpT95ZsA
        lAS5mWRdlTtYKdgFWSSHdB+mPYJfBWZtSK0JjYmctuXl0+/jVmI1JO1i8zvzag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678459793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WT6x5ALV9Avon1agL1/IFmPx2GHhD7TtkWqFlKSXWUk=;
        b=0OC5ksB15x8S4Q7OlJlm4pNkL3gVRT68cm/XJtMhBsrM/wt8jXFbNQC20moCdgqRvDZJ0Y
        P4X1qasSwlq9YfCg==
Date:   Fri, 10 Mar 2023 15:49:53 +0100
MIME-Version: 1.0
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAK7LNASjiAB93mu0igQsiwgu=zrgu3gArMJZ+6CXHuJ+kG_ELg@mail.gmail.com>
 <20230307112028.14190-1-bage@linutronix.de>
 <20230307112028.14190-2-bage@linutronix.de>
 <CAK7LNASJeECGBiaWNjdhDbnBP3-8TKUOCXXbmbu8C9+Qa4FDxg@mail.gmail.com>
Content-Language: de-DE-frami
From:   Bastian Germann <bage@linutronix.de>
Subject: Re: [PATCH v2 1/1] kbuild: deb-pkg: default dpkg-buildpackage --build
In-Reply-To: <CAK7LNASJeECGBiaWNjdhDbnBP3-8TKUOCXXbmbu8C9+Qa4FDxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 10.03.23 um 15:37 schrieb Masahiro Yamada:
> If this patch is applied, 'make deb-pkg'
> would not produce the source package at all.

How so? Are you saying `make deb-pkg` never built a source package with <= 6.2?
Because those never specified a --build.

> Now I recalled the reason why I added this.
> 
> 
> 
> dpkg-buildpackage(1):
> 
>   full
>       Builds everything.  This is an alias for source,any,all, and the
>       same as the default case when no build option is specified.
>                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

full is the default for --build. I guess the wording here is so tedious
because you can have -S, -b, -B and so on which all imply some --build.

> NACK
