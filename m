Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9385F707BBA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 10:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjERISR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 04:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjERISM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 04:18:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A4CDA
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 01:18:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EC85648E5
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 08:18:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC089C433D2;
        Thu, 18 May 2023 08:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684397890;
        bh=mhq6g/AfkPR7b1DbNCYH4F7yhryblueuRYacn+yeNF4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Uii5BuMZU1oB1tK3hGjXh1QVAaMjcIzTxl/Lo6U9Zehph3f66xa9B6FCstimuU6SJ
         2upXMmJ4pA7YY3Mq7LNjgjc8JnCOCshD18qM5/8C6dIEHAml6wNpDldrqjP6sF9gVB
         mhGY2wQpcn9Cp7g1b/xOtl4iLsYVknrXHdS8Gjq28yI6YSzYQO7t+rSXNuTjFK+BpN
         Nny+qiHm1niBDigSDFqqP66wy7HjdbuwOdHRFnsa3Jzq63ZTJ6EVY2Amij46sZzAe1
         lCfLkeJEAAEfhPn9q7LAV6U4sLCKdVBVFiGYJpVyI/v5/OnZNEk3M5LqGuSvVZ57n6
         VcPRfbuNM7djg==
Date:   Thu, 18 May 2023 10:18:04 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     oleg@redhat.com, linux@leemhuis.info, nicolas.dichtel@6wind.com,
        axboe@kernel.dk, ebiederm@xmission.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com
Subject: Re: [RFC PATCH 3/8] fork/vhost_task: Switch to CLONE_THREAD and
 CLONE_SIGHAND
Message-ID: <20230518-antiseptisch-bahnt-90230ccbd1ff@brauner>
References: <20230518000920.191583-1-michael.christie@oracle.com>
 <20230518000920.191583-4-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230518000920.191583-4-michael.christie@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 07:09:15PM -0500, Mike Christie wrote:
> This is a modified version of Linus's patch which has vhost_task
> use CLONE_THREAD and CLONE_SIGHAND and allow SIGKILL and SIGSTOP.
> 
> I renamed the ignore_signals to block_signals based on Linus's comment
> where it aligns with what we are doing with the siginitsetinv
> p->blocked use and no longer calling ignore_signals.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---

Yes, much nicer than what this was before,
Acked-by: Christian Brauner <brauner@kernel.org>
