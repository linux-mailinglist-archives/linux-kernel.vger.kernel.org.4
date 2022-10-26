Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6680E60DAEF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 08:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbiJZGFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 02:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbiJZGE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 02:04:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C67153D20
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 23:04:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07A0561CF8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 06:04:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF2B6C433B5;
        Wed, 26 Oct 2022 06:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666764297;
        bh=YzRMUuZtNje+a9bdS2vE+iVnqGt9NamYfN5MBaoJaXE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rnTWDXJ0eecn4uSfH2eN5KcFihxZfpvtO8pAd20KYGz4beuL0lrVuJAUxn1x+99/q
         555qoNKDn6tT84rP4B1E3JSNt+ojyE/TCbJukhYbf6961o5H9FZYSdlu0ERex/G7Dy
         rsAC03uTew5TtUmVKgh+h3wJVUqPzjARXX1a29DEDJLhaSsxdnttbEMtd6KwX/myEQ
         9I0LaA7CIJ7ZLM/bKFsnrXn0Kp6lUE/HOMyGCyPVH0dh5KDINGv4pI34eIMGnCpYRL
         ibnq6/WLrEJq/+4QHiV7fMXGWpi+v0AGPmlVBIZ6TAJpuoAlroKGrsfGyG+p1tRubK
         qMHTJtxyweNAA==
Date:   Wed, 26 Oct 2022 09:04:44 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memblock: remove repeat round
Message-ID: <Y1jN/KeU6dgJWQIL@kernel.org>
References: <Y1a6BoawCoDDCo/K@kernel.org>
 <20221019120337.2098298-1-yajun.deng@linux.dev>
 <6cccd4cba4f8407d52815c68f60446fb@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cccd4cba4f8407d52815c68f60446fb@linux.dev>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 03:24:58AM +0000, Yajun Deng wrote:
> October 25, 2022 12:15 AM, "Mike Rapoport" <rppt@kernel.org> wrote:
> 
> >> @@ -598,22 +597,6 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
> >> return 0;
> >> }
> >> 
> >> - /*
> >> - * The worst case is when new range overlaps all existing regions,
> >> - * then we'll need type->cnt + 1 empty regions in @type. So if
> >> - * type->cnt * 2 + 1 is less than type->max, we know
> >> - * that there is enough empty regions in @type, and we can insert
> >> - * regions directly.
> >> - */
> >> - if (type->cnt * 2 + 1 < type->max)
> >> - insert = true;
> >> -
> >> -repeat:
> >> - /*
> >> - * The following is executed twice. Once with %false @insert and
> >> - * then with %true. The first counts the number of regions needed
> >> - * to accommodate the new area. The second actually inserts them.
> >> - */
> >> base = obase;
> >> nr_new = 0;
> > 
> > I believe nr_new variable is no longer needed, is it?
> > 
> No, nr_new is needed before memblock_merge_regions() for return.

Why?
 

-- 
Sincerely yours,
Mike.
