Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059BB5B36A6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 13:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiIILrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 07:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiIILrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 07:47:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5738B131EDC
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 04:47:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 172F7B82489
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 11:47:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F6A1C433C1;
        Fri,  9 Sep 2022 11:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662724030;
        bh=7suUxrvFUF/KkgYl83T/YM3TrdL0T05prCH6RXiZcy4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I0V48tMfmGxxXD/VutHGMHHJIEBJr3cTGkIGnEknRHdMsUKhguNcNjuFNV/1yntaI
         L3xJ6WdNg2DZvndCZiL4QNSY0lQmkPhPUj8YFnkcKVU0XoA284rkDv6RoTRPpx9SBR
         2YbIlpLK188RZ0y2bbDl+iXp/7OZvPJeYX0AxvAM=
Date:   Fri, 9 Sep 2022 13:47:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nam Cao <namcaov@gmail.com>
Cc:     forest@alittletooquiet.net, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v2] staging: vt6655: use memset to make code clearer
Message-ID: <YxsnzortdWmj+niV@kroah.com>
References: <20220909090856.18427-1-namcaov@gmail.com>
 <YxsUEUqbKRW85Z24@kroah.com>
 <CA+sZ8B_XzDO8pgFJLMzObBMo6KYHeYsttfYNoSUi+CGf8293xA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+sZ8B_XzDO8pgFJLMzObBMo6KYHeYsttfYNoSUi+CGf8293xA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 01:29:44PM +0200, Nam Cao wrote:
> On Fri, Sep 9, 2022 at 12:23 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > Why do you have to cast this to (void *)?  That should almost never be
> > needed.
> 
> Because I want to suppress a compiler warning:
> drivers/staging/vt6655/device_main.c:869:9: warning: passing argument
> 1 of ‘memset’ discards ‘volatile’ qualifier from pointer target type
> [-Wdiscarded-qualifiers]
>   869 |  memset(&rd->rd0, 0, sizeof(rd->rd0));
>       |         ^~~~~~~~

Why would that have a type of "volatile"?  That should be fixed first
please.

thanks,

greg k-h
