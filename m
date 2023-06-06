Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8BE723F6E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 12:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234931AbjFFK1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 06:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbjFFK1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 06:27:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E3110E5
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 03:27:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 063A16250A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 10:27:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE29BC4339C;
        Tue,  6 Jun 2023 10:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686047258;
        bh=rH+M9QzMpxBG0FLiDNmAIZ6ZGxVLEeWHTocCtWMNCs4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nmNsU0r2a26bGWhRpWWtePdL4IuTbW/4D9QNNUNf0XGFJabMFOWOf2rTsqY92MWIu
         ZN4jBRKGnmy8w2ISLv8Ajb4iVN9BntEEw/3321faudzvHtB8fYFIFcwMkoapZfOLRg
         bbaBubDReMSYTSOwU05NI/hgiG0iKvD2FH1A5bQ1bi/gjo4DZYiMhyZ0TxeSp33pU4
         PaUapui+3vmCQ/SyxCXrbIJsKiq029+SqJ/fs4ww3xM7GSKaOM8ovAeGhPBxsAVReJ
         7VIC341oWkfTrOv97Cb3XuTzPFCM7k2PkJimPZJKVWS7hwT+b45p9pRtLEJr/41s6P
         CbTlPUxm4ZvgA==
Date:   Tue, 6 Jun 2023 12:27:35 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH v7 12/21] timer: Keep the pinned timers separate from the
 others
Message-ID: <ZH8KF8cUrOnQXgf1@lothringen>
References: <20230524070629.6377-1-anna-maria@linutronix.de>
 <20230524070629.6377-13-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524070629.6377-13-anna-maria@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 09:06:20AM +0200, Anna-Maria Behnsen wrote:
> Separate the storage space for pinned timers. Deferrable timers (doesn't
> matter if pinned or non pinned) are still enqueued into their own base.
> 
> This is preparatory work for changing the NOHZ timer placement from a push
> at enqueue time to a pull at expiry time model.
> 
> Originally-by: Richard Cochran (linutronix GmbH) <richardcochran@gmail.com>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
