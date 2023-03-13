Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363236B8145
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjCMS5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjCMS4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:56:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204F919B5;
        Mon, 13 Mar 2023 11:56:54 -0700 (PDT)
Message-ID: <63232be8-59f6-8b93-96be-730f5126f60c@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678733812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0bhuaZpzaQLkT/xE4WWh7CLcCO0YO4CJWdvp3MzvLTk=;
        b=k+DJfIFVFT/becv3n48nayXKsfvVbu7b+DYJtSh9+Xa5f5vtVN28Bfh36e1jRatPhGMrmU
        LWh2ngadRZAZoqRyf9PIO4LClPtx2W6yJsvNdh5zylWlKITKy+SUSjk9ZHbG3vo8ZgN1QQ
        +heGw8G6L9BChhre+pZm0t4W6vqtowuMrJgDtQoi6Ukn0JhzhSk0zJOwc5dx4nB6W0qCql
        i81BupeXsCoejF3jHvaDonKdV3c4eLg0/jU4yLJpOpZlhaPJTBkvtZmxotk+MZ0KVy/O1i
        VlPO77fnL+IinQaeBlpb7ZZsJ697nzPy6nG0dYxZPJMiHyqyOUgvCqkSTnkrFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678733812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0bhuaZpzaQLkT/xE4WWh7CLcCO0YO4CJWdvp3MzvLTk=;
        b=LZARHa3JQVmqP3YxvHdX4gtXSiSImkEdQaA6dsyAg8slNL8yRH0qBrnDVEcK3w/auOYnws
        XaINcWk3SGKLHbDA==
Date:   Mon, 13 Mar 2023 19:56:51 +0100
MIME-Version: 1.0
Content-Language: de-DE-frami
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230313171036.268407-1-bage@linutronix.de>
 <20230313171036.268407-2-bage@linutronix.de>
 <CAK7LNARd8rQdwauAvgSo-+wxv=rU-4tTCtrzRJ2uhgWRrt6Xxw@mail.gmail.com>
From:   Bastian Germann <bage@linutronix.de>
Subject: Re: [PATCH 1/1] kbuild: deb-pkg: Allow parallel build
In-Reply-To: <CAK7LNARd8rQdwauAvgSo-+wxv=rU-4tTCtrzRJ2uhgWRrt6Xxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 13.03.23 um 18:59 schrieb Masahiro Yamada:
> On Tue, Mar 14, 2023 at 2:10 AM Bastian Germann <bage@linutronix.de> wrote:
>>
>> Currently, the only way to build the deb-pkg generated package parallely
>> is adding -jN to the MAKEFLAGS environment variable. The package ignores
>> the usual parallel build option that is described in Debian Policy §4.9.1.
> 
> 
> 
> "dpkg-buildpackage -b -j16" worked for me.

This ends up in DEB_BUILD_OPTIONS=parallel=16 being set and the call:
/usr/bin/make -f ./Makefile ARCH=x86 	KERNELRELEASE=6.3.0-rc2 KBUILD_BUILD_VERSION=1 	olddefconfig all

So it is not used to run the actual build, just the top level `make -f debian/rules` invocation.
You can set --jobs-force=16, which ends up in MAKEFLAGS but the point of the patch is that one can use
the usual way of parallelizing.

Side note: Without the patch, the build is run with -j1 regardless of being called from the Linux Makefile
or dpkg-buildpackage.
