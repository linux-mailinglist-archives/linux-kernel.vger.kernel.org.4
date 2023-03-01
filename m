Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0606A7861
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 01:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjCBA2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 19:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjCBA2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 19:28:21 -0500
X-Greylist: delayed 1199 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Mar 2023 16:28:06 PST
Received: from gnu.wildebeest.org (gnu.wildebeest.org [45.83.234.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11EE32E66;
        Wed,  1 Mar 2023 16:28:05 -0800 (PST)
Received: by gnu.wildebeest.org (Postfix, from userid 1000)
        id 221EF30067B2; Thu,  2 Mar 2023 00:52:33 +0100 (CET)
Date:   Thu, 2 Mar 2023 00:52:33 +0100
From:   Mark Wielaard <mark@klomp.org>
To:     John Moon <quic_johmoo@quicinc.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Todd Kjos <tkjos@google.com>,
        Matthias Maennich <maennich@google.com>,
        Giuliano Procida <gprocida@google.com>,
        kernel-team@android.com, libabigail@sourceware.org,
        Jordan Crouse <jorcrous@amazon.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>
Subject: Re: [PATCH v2 0/2] Validating UAPI backwards compatibility
Message-ID: <20230301235233.GJ12496@gnu.wildebeest.org>
References: <20230301075402.4578-1-quic_johmoo@quicinc.com>
 <CAKwvOdmqShYae=DrwP1JZBYXAYZyDB0SaOkVCvCzQC60MaJcpw@mail.gmail.com>
 <41d287fa-3a0a-cac6-4595-ad47ef873d79@quicinc.com>
 <0c92e7b8-e415-8ad5-14e7-d94f18c3fa25@quicinc.com>
 <b2055eab-4762-5fbf-8ea6-0956a0a2eb58@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2055eab-4762-5fbf-8ea6-0956a0a2eb58@quicinc.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Wed, Mar 01, 2023 at 02:33:00PM -0800, John Moon via Libabigail wrote:
> With some additional help from Nick offline, we determined that the
> issue isn't with clang, but with libdw (from elfutils). You need at
> least libdw version 0.171 for the abidiff tool to work correctly
> with clang (in this particular case). Ubuntu 18.04 ships with
> version 0.170.

I don't remember any specific fixes for clang in libdw for elfutils
0.171. But elfutils 0.171 was the first release that supported most of
DWARF5 (including GNU DebugFission and split dwarf).

> If there's any interest, it'd be fairly easy to add a check for this
> condition under the check_deps() function in the script.

Please do add this check. elfutils 0.170 is almost 6 years old now,
there have been many, many bug fixes since then (current release is
0.188 from Nov 2022).

Thanks,

Mark
