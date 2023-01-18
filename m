Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4E6671B41
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 12:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjARLyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 06:54:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjARLwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 06:52:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB096E831;
        Wed, 18 Jan 2023 03:09:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CBF97B81C16;
        Wed, 18 Jan 2023 11:09:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC90FC433EF;
        Wed, 18 Jan 2023 11:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674040188;
        bh=NZW9HiYlTqxS3hzsVzUHhCSns2PIpY7e66VoK9HVTLg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V9GY2h1POWPM4omeBU1RQWCB2P8xzsiyNNn4SDIbh96+c0FJw9PzlpDWU9R9o0Mnl
         eg7DDc2wABs+Fbiw8FseF24qqKr9sDgLqNUthJjtq25MdasDkU3GxCO2OfPH7FKO1J
         XDQ1cuwB5qKVCTjOzK+gxK7l4Miif+6KTQhLAp2OQJRMkp1l+FjzEnmTHP6byD/aj2
         bCLGvCdbTthkBWATMpGnPkx/afltV13dA3iO5O0XL4hE286F4OuhqRVWrBDDFDLChB
         fY0Lsh/GE+dBeVLoTI0vQ/JEhwQkXOC43ySr1ZnBc5lwvtyMoztYJ5qimuYcqRkDoN
         ACi0p1kS9b2HQ==
Date:   Wed, 18 Jan 2023 11:09:43 +0000
From:   Lee Jones <lee@kernel.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     benjamin.tissoires@redhat.com, avid.rheinsberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH 1/2] HID: core: Provide new max_buffer_size attribute to
 over-ride the default
Message-ID: <Y8fTd0VJXqKkPIuo@google.com>
References: <20230113150557.1308176-1-lee@kernel.org>
 <nycvar.YFH.7.76.2301181002550.1734@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.YFH.7.76.2301181002550.1734@cbobk.fhfr.pm>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jan 2023, Jiri Kosina wrote:

> On Fri, 13 Jan 2023, Lee Jones wrote:
> 
> > Presently, when a report is processed, its size is compared solely 
> > against the value specified by user-space.  
> 
> While I am generally fine with the idea, I don't understand this sentence. 
> What exactly do you mean by 'specified by user-space'? It's defined as a 
> compile-time constant.
> 
> > If the received report ends up being smaller than this, the
> > remainder of the buffer is zeroed. 

Apologies for any ambiguity.

"its size" == "compile-time constant"

Would "its maximum size" read better?

These sentences are an attempt to describe this statement:

    if (csize < rsize) {
        dbg_hid("report %d is too short, (%d < %d)\n", report->id,
            csize, rsize);
        memset(cdata + csize, 0, rsize - csize);
    }

Where csize is "the [size of the] received report" and rsize is the
"value [size] specified by user-space".  Thus, if user-space says the
report will be 8-Bytes (rsize) and it actually only only submits 6-Bytes
(csize), then the subsystem will complain that the "report is too short"
and it will attempt to zero the seemingly unused 2-Bytes.

-- 
Lee Jones [李琼斯]
