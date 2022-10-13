Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5E65FE186
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 20:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbiJMSlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 14:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbiJMSlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 14:41:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE301793A7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 11:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665686291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NG69KUQLGA9z81hwdboaz/+6KNpRRfBl8D7k454xSQo=;
        b=GSSKu96IUa/CpDbVL/nL/oPZNF08Gsx7mDWweY0HDjmVaR09gkqtAz5GMUbJ8dCmJPQt7P
        f8gqzHFBiQeHQ60IkWDd6Sb0Nwh8sKfYkZrIt3hF1/YitxrypAc3HKxamdJfM7xTn1K0Tt
        DbwqwOzXbG8ndxxqUYProJnB0npVmE4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-512-42TCTuw4NJCjZjL9e3PG6g-1; Thu, 13 Oct 2022 14:38:06 -0400
X-MC-Unique: 42TCTuw4NJCjZjL9e3PG6g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E01061C00147;
        Thu, 13 Oct 2022 18:38:05 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.73])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A438B477F60;
        Thu, 13 Oct 2022 18:38:04 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-toolchains@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: gcc 5 & 6 & others already out of date?
References: <CAHmME9prBJHmo9Bw6aobuGLjtxLsjxKJ9wopOv5+BY6ZtuKaNg@mail.gmail.com>
        <Y0gLyLbdOCetX5LN@sirena.org.uk> <Y0gteD0QYVlYxSZh@zx2c4.com>
        <Y0g8HEYHZYHGdwlf@sirena.org.uk> <Y0g+wTTJmlaFVLzr@zx2c4.com>
        <Y0hH5NelZ03yfQuU@sirena.org.uk>
Date:   Thu, 13 Oct 2022 20:38:02 +0200
In-Reply-To: <Y0hH5NelZ03yfQuU@sirena.org.uk> (Mark Brown's message of "Thu,
        13 Oct 2022 18:16:20 +0100")
Message-ID: <87o7ufwovp.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mark Brown:

> On Thu, Oct 13, 2022 at 10:37:21AM -0600, Jason A. Donenfeld wrote:
>
>> Regarding "one extreme to the other", I suspect that in spite of my
>> arguments, which would seem to justify an extreme, the actual thing I
>> suggested is a bit more moderate: let's support the latest 2 or 3 gccs
>> at the time of kernel release. If we choose 3, that's roughly 3 years of
>> gccs, right? 3 years seems like a fairly long amount of time.
>
> I was looking at your suggestion there - as a Debian user that feels a
> touch enthusiastic (though practically probably not actually a problem)
> since it's not too far off the release cadence, current Debian is at GCC
> 10 and we're not due for another release till sometime next year which
> will be right on the three years.

Debian also has Clang 13, presumably for building Rust and Firefox.

> There does also seem to be a contingent of people running enterprise
> distros managed by an IT department or whatever who may take a while
> to get round to pushing out new versions so for example might still
> for example be running Ubuntu 20.04 rather than 22.04 (never mind the
> people I know are sitting on 18.04 but that's another thing).

The enterprise distributions have toolchain modules or toolsets that you
can install, all nicely integrated.  You'd probably consider those
versions too new. 8-/   I expect it's mostly an education issue, raising
awareness of what's available from vendors.   (glibc versions are a
different matter, but I don't think dropping support for historic
versions on build hosts is on the table, so that should be relevant.)

Compiler version requirements probably impact the people most who build
their own toolchains for whatever reason.  There must be unusual targets
where the upstream toolchain currently cannot build a booting kernel,
for instance.  If you require newer toolchain features in generic code,
it could bring some temporary suffering to those people: they need to
fix their toolchain before they can contribute again to the mainline
kernel.

Thanks,
Florian

