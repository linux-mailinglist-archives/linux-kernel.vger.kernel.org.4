Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2187A689C1E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 15:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbjBCOrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 09:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233150AbjBCOrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 09:47:31 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id A0A109EE01
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 06:47:29 -0800 (PST)
Received: (qmail 563062 invoked by uid 1000); 3 Feb 2023 09:47:28 -0500
Date:   Fri, 3 Feb 2023 09:47:28 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Zhu Zhongjie <zhongjiezhu1@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: core: hub: fix usb_hub worker blocking
 drain_all_pages() worker issue
Message-ID: <Y90egBL6HSoEdz2P@rowland.harvard.edu>
References: <20230203072819.3408-1-zhongjiezhu1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203072819.3408-1-zhongjiezhu1@gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 03:28:19PM +0800, Zhu Zhongjie wrote:
> From: Zhongjie Zhu <zhongjiezhu1@gmail.com>
> 
> When disconnecting a usb mass storege, if there are a lot of inodes
> like 10 thousands files need to be freed, the invalidate_inodes() will
> run for a loog time to freeing all inodes, this will block other worker
> to run in the cpu, so mark the usb_hub workqueue to WQ_CPU_INTENSIVE to
> avoid this situation.

Very infrequently this will happen.  In the vast majority of cases, the 
usb_hub workqueue uses very little CPU time.  Marking it 
WQ_CPU_INTENSIVE seems inappropriate.

Alan Stern
