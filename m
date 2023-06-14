Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5987308F2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 22:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236014AbjFNUJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 16:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjFNUJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 16:09:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D90410EC
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 13:09:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A85FB61CA0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 20:09:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F39C433C8;
        Wed, 14 Jun 2023 20:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686773350;
        bh=NHJ7GNd7KZg20wKuw0+Py4z5TqOF5JZB/FaRyYfbBtE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lXCWMmmxxy6gfFzdn9WeFBBD7v2JuvUmg2qHWAha8Avg0TRM6+GJoDYp4OhzyZuRI
         EOBbcwdaGn0u6NZ4DERb0rn49h7sc/i9CnOr6oMt6Rsgj6ZR5ij9D9YiskpJqAye5i
         kWG6YiJADLV7ybS41FrEdmbTwgVUQJR0IXDQhLKU=
Date:   Wed, 14 Jun 2023 22:09:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xia Fukun <xiafukun@huawei.com>
Cc:     prajnoha@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] kobject: Fix global-out-of-bounds in
 kobject_action_type()
Message-ID: <2023061444-latticed-discuss-fa70@gregkh>
References: <20230518091614.137522-1-xiafukun@huawei.com>
 <86c6040d-17ab-fb01-2b75-717d82ba9345@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86c6040d-17ab-fb01-2b75-717d82ba9345@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 07:32:38PM +0800, Xia Fukun wrote:
> 
> On 2023/5/18 17:16, Xia Fukun wrote:
> > ---
> > v6 -> v7:
> > -  Move macro UEVENT_KACT_STRSIZE to the .c file to 
> > improve maintainability.
> > 
> 
> Gentle ping ...
> 
> UEVENT_KACT_STRSIZE is defined as the maximum length of the string
> contained in kobject_actions[].
> 
> At present, the maximum length of strings in this array is 7. Based on
> the actual meaning of these strings, these actions will not exceed 16
> if there are any subsequent changes.
> 
> I have submitted v7 of the patch according to your suggestion and
> tested it to ensure its functionality is correct.

It's in my to-review queue, but I was hoping that others would at least
test it out given that the previous versions had so many problems.  I am
loath to do that on my own, sorry.

> Please take the time to review it.

How did you test it?  How have you verified that the previous failures
were caught this time?

You can understand my hesitancy here, right?

thanks,

greg k-h
