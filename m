Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5F668ED2A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 11:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjBHKk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 05:40:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbjBHKki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 05:40:38 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 666794955A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 02:40:00 -0800 (PST)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 318AdaVU000323;
        Wed, 8 Feb 2023 11:39:36 +0100
Date:   Wed, 8 Feb 2023 11:39:36 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     chris.chenfeiyang@gmail.com
Cc:     paulmck@kernel.org, Feiyang Chen <chenfeiyang@loongson.cn>,
        arnd@arndb.de, chenhuacai@kernel.org, jiaxun.yang@flygoat.com,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] tools/nolibc: Add statx() and make stat() rely on
 statx() when available
Message-ID: <Y+N76C7hfcu5Ze/J@1wt.eu>
References: <cover.1675851111.git.chenfeiyang@loongson.cn>
 <b9bbf73286238bb4657d855c9d50983aa17953e2.1675851111.git.chenfeiyang@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9bbf73286238bb4657d855c9d50983aa17953e2.1675851111.git.chenfeiyang@loongson.cn>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Feiyang,

On Wed, Feb 08, 2023 at 06:17:51PM +0800, chris.chenfeiyang@gmail.com wrote:
> From: Feiyang Chen <chenfeiyang@loongson.cn>
> 
> loongarch and riscv32 only have statx(). arc, hexagon, nios2 and
> openrisc have statx() and stat64() but not stat() or newstat().
> Add statx() and make stat() rely on statx() to make them happy.

Thanks for this, that's way better. I'm just having one small request
below:

> +/*
> + * int statx(int fd, const char *path, int flags, unsigned int mask, struct statx *buf);
> + */
> +
> +static __attribute__((unused))
> +int sys_statx(int fd, const char *path, int flags, unsigned int mask, struct statx *buf)
> +{
> +	return my_syscall5(__NR_statx, fd, path, flags, mask, buf);
> +}
> +
> +static __attribute__((unused))
> +int statx(int fd, const char *path, int flags, unsigned int mask, struct statx *buf)
> +{
> +	int ret = sys_statx(fd, path, flags, mask, buf);
> +
> +	if (ret < 0) {
> +		SET_ERRNO(-ret);
> +		ret = -1;
> +	}
> +	return ret;
> +}

Please guard these inside #if defined(__NR_statx) so that this can still
be used as-is from slightly older toolchains that provide their own kernel
includes.

The rest of the series looks pretty good to me.

Thank you!
Willy
