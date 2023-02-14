Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A506D69590A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 07:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjBNGRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 01:17:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjBNGR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 01:17:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD121CAEE
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 22:17:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C32B2B81BD6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 06:17:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE764C433EF;
        Tue, 14 Feb 2023 06:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676355434;
        bh=F+1/v/vPsWEn/QcLbLorm7SHarUQPNLSDxKMczlWb04=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qmpVofMdNGQCJcWUrCeNLsJgH25Q6asj8FFDoPfICuzYIIWrL1gljGFF/PSDgALcx
         Bc3ftCrnYL+CYTaaUPJzmU8F189pBQDlCQWT5FR/FbzBazzINNKdMx4sdl5H6aQLw2
         QdnThUBA+j3ErPBx/XwNENez91TOchssrfU+mizo=
Date:   Tue, 14 Feb 2023 07:17:10 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Carlos Llamas <cmllamas@google.com>
Cc:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Jialu Xu <xujialu@vimux.org>, linux-kernel@vger.kernel.org
Subject: Re: libpcre2 breaks COMPILED_SOURCE=1 tags
Message-ID: <Y+snZioVyo82mAUj@kroah.com>
References: <Y+qYdA7OpRX16Lwf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+qYdA7OpRX16Lwf@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 08:07:16PM +0000, Carlos Llamas wrote:
> Newer versions of libpre2 have dropped default support for \K in
> lookarounds. Unfortunately, scripts/tags.sh relies on this option to
> collect all the _compiled_ sources. This is the error:
> 
>   $ make COMPILED_SOURCE=1 tags
>     GEN     tags
>   grep: \K is not allowed in lookarounds (but see PCRE2_EXTRA_ALLOW_LOOKAROUND_BSK)
> 
> It seems there isn't an official maintainer for this script and I can't
> quite understand the regex used for the query. Does anyone have a good
> alternative for this? The regex pattern was introduced in commit
> 4f491bb6ea2a ("scripts/tags.sh: collect compiled source precisely").
> 
> The previous form of all_compiled_sources() seems to work for me and I'm
> guessing it wasn't efficient enough? I can't find much info about the
> switch to find/grep either. I believe the initial thread is this:
> https://lore.kernel.org/all/20200423103801.GA3730892@kroah.com/

Can you send a patch to revert the offending change?  That would be the
simplest for now, right?

thanks,

greg k-h
