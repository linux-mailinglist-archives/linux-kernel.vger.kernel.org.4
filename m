Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A9766D5A9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 06:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235406AbjAQFhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 00:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbjAQFgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 00:36:42 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07932799D;
        Mon, 16 Jan 2023 21:36:41 -0800 (PST)
Date:   Tue, 17 Jan 2023 05:36:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=t-8ch.de; s=mail;
        t=1673933799; bh=oba6/bCy0Rb5hWMxSdHbU7NQMwYatUQpsIdj9M8X3zc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E3Wnk/Wfq/l5MRwxABzc+86xfblfON9WX6AaC2rYXCqwpx7wgWcSE6azdIYV8MIdl
         a3ksRHl7UiC34bN2VDyXjtE6N8ZAMGYGclEFjHlHcCNXfk8jnQmWgExddV50Dq07Ix
         LkZ0WEzWXohB+cAfikGe/NotsV7PyQU2aQLbh+7g=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Amy Parker <apark0006@student.cerritos.edu>
Cc:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: Kernel builds now failing
Message-ID: <20230117053637.viuu75chipgx42oi@t-8ch.de>
References: <CAPOgqxFva=tOuh1UitCSN38+28q3BNXKq19rEsVNPRzRqKqZ+g@mail.gmail.com>
 <20230116195357.2jq7q262tongxw52@t-8ch.de>
 <CAPOgqxFtH4Ezb1xVm3kOLBnOnQfpbs4==Kpefhaxz4JhOObqOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPOgqxFtH4Ezb1xVm3kOLBnOnQfpbs4==Kpefhaxz4JhOObqOA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 03:10:25PM -0800, Amy Parker wrote:
> On Mon, Jan 16, 2023 at 11:54 AM Thomas Weiﬂschuh <linux@weissschuh.net> wrote:
> > I expect this to be due to a change in make 4.4 that ignores SIGPIPEs [0].
> > So programs called from make will not receive a SIGPIPE when writing to
> > a closed pipe but instead an EPIPE write error.
> > `find` does not seem to handle this.
> 
> Thank you so much for the clarification! I've also seen reports of
> other tools not handling it (such as `yes').

I think this analysis was wrong. For me I got this error because on a
new ArchLinux installation the command "cpio" is not present, leading to
this cryptic error.
I sent a patch to make the error more obvious:
https://lore.kernel.org/all/20230117-kernel-kheaders-cpio-v1-1-058d3e1c8621@weissschuh.net/

Does it work for you after installing the package "cpio"?

It does not explain why it only stopped working for you recently,
though.

> > This behavior in make is new and I can't find a reasoning for it.
> > It also breaks other softwares builds.
> 
> Are you aware of active discussion regarding this on Savannah, or
> should I go and report the effects there?
> 
> > For now you can disable CONFIG_IKHEADERS and the build should work
> > again.
> 
> Alright, thanks. Did that, and re-ran my kernel build (allmodconfig).
> All works now.
> 
> > [0] make 4.4 was packaged for ArchLinux on 5th of January, so it would
> > fit the timeline.
> 
> Yep, running Make 4.4.
