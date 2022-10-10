Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539505F9721
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 05:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiJJDDX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 9 Oct 2022 23:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiJJDDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 23:03:17 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7143C5072D
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 20:03:13 -0700 (PDT)
X-QQ-mid: bizesmtpipv601t1665370964tu3d
Received: from SJRobe ( [255.214.198.8])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 10 Oct 2022 11:02:43 +0800 (CST)
X-QQ-SSF: 01100000000000G0Z000000A0000000
X-QQ-FEAT: zT6n3Y95oi1z8zdxsRWsbSlFVf0jAbvLSoajH5gkEwqRkOVI8QkH2Ra5iUvbH
        Oj4eE6T8UFOfHFQldxBEmSjURTiZup/pkTP9hghp1K2FiLLiKAtVATuZ+oSgAHvyRF42mb7
        kE2MLM2bJ6ZltFWRLJTo9B8QMGKqfxIMmzfFXFBHv6Mn0ah6ZPmgpzRYB3zOholqeMze7YB
        dgzDd4Ecaf9/An2zUPmCPfbT29G/jVXUcQ3v/ZP6tt4Mr/jT1iDWCeY+FyEd5DUK7uCCh94
        ZtUvbEFHrZI9qqFv0bWTONoALlNs+L9e3JDHbPLHJt3vcCFF19hROHp5BKaFbdFlIxUyVmP
        j448JuWGDRFzRHs+VTs7vHLOzEzGyMGS3j9VGT30IlunvQ2kNqs1EgjK6LmsxhJ/FfSoiLH
X-QQ-GoodBg: 0
From:   "Soha Jin" <soha@lohu.info>
To:     "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>
Cc:     "'Rafael J. Wysocki'" <rafael@kernel.org>,
        "'Andy Shevchenko'" <andriy.shevchenko@linux.intel.com>,
        "'Daniel Scally'" <djrscally@gmail.com>,
        "'Heikki Krogerus'" <heikki.krogerus@linux.intel.com>,
        "'Sakari Ailus'" <sakari.ailus@linux.intel.com>,
        <linux-kernel@vger.kernel.org>
References: <20221009162155.1318-1-soha@lohu.info> <20221009162155.1318-2-soha@lohu.info> <Y0MR+uSDEm2bPgcD@kroah.com>
In-Reply-To: <Y0MR+uSDEm2bPgcD@kroah.com>
Subject: RE: [PATCH 1/3] string: add match_string_nocase() for case-insensitive match
Date:   Mon, 10 Oct 2022 11:02:39 +0800
Message-ID: <EE2940315EA6EAA4+1b3101d8dc54$c2f83680$48e8a380$@lohu.info>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJ3YxYd+FPcuiJVmWEOx+0wAFDAtAEC1QTIAidE926ssJJBUA==
Content-Language: fr
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpipv:lohu.info:qybglogicsvr:qybglogicsvr3
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,RCVD_ILLEGAL_IP,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,
> On Mon, Oct 10, 2022 at 12:21:53AM +0800, Soha Jin wrote:
> > Sometimes we want to make a case-insensitive comparison with strings,
> > like checking compatible devices in fwnode properties, so this commit
> > abstracts match_string to __match_string with a compare function. The
> > original match_string will call __match_string with strcmp, and the
> > new match_string_nocase will call it with strcasecmp.
> 
> Wait, no, fwnode properties are case sensitive, why are you allowing that to
> be changed?  That sounds like broken firmware to me, right?
> 

I am writing regarding the compatibility. In `of_device_is_compatible`, it
uses `of_compat_cmp` which calls `strcasecmp` to match compatible property.

As the `fwnode_is_compatible` should be the replacement of the OF way, I
think we should make the fwnode way and the OF way the same, i.e. either
both case-insensitive or case-sensitive, to keep the consistency. I am
afraid that make `of_compat_cmp` case-sensitive may break a great many of
devices, that is why I am doing this.

Regards,
Soha

