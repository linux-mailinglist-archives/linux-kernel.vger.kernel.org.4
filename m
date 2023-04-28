Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9064F6F1B5A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 17:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346172AbjD1PVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 11:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjD1PVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 11:21:42 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4128359D;
        Fri, 28 Apr 2023 08:21:38 -0700 (PDT)
Date:   Fri, 28 Apr 2023 17:21:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1682695296; bh=CYqaizHLeRnV10tC29jVmtrq/c4Tu+2GaG5uVrIUCxk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a31Oww46roN0t0R010n5A7vwCn0IxGRMw34Sl8rDVICpCRFJPHXXg5ienSWdccPVa
         L5TpBu25BExqXk2oFrl/rGdNb69mWeSw90cPbhjYpiWMsiKXvWluKWcibbU8hcmHS/
         tDEY5TLdY0WUSZnA6O8XmbdcY9IVJB5+KPWQEjYA=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Jorge Lopez <jorgealtxwork@gmail.com>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 12/14] HP BIOSCFG driver - surestart-attributes
Message-ID: <7bdac640-cf61-429f-acd0-f8aa40b41e73@t-8ch.de>
References: <20230420165454.9517-1-jorge.lopez2@hp.com>
 <20230420165454.9517-13-jorge.lopez2@hp.com>
 <cf54c6f4-d177-4904-82ee-9d33566fb920@t-8ch.de>
 <CAOOmCE8rpA=XvWBxcyRVu_gOHie3qN0E15Rs9bLfhb6tPZ7tyg@mail.gmail.com>
 <479b18e3-a35b-45c7-8c8a-cd30af646977@t-8ch.de>
 <CAOOmCE87dV6pnnU7r8Ycf0XcVERpRFRZeK6=y+nC+_Fc1EuJMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOOmCE87dV6pnnU7r8Ycf0XcVERpRFRZeK6=y+nC+_Fc1EuJMg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-28 09:58:01-0500, Jorge Lopez wrote:
> On Fri, Apr 28, 2023 at 1:03 AM Thomas Weißschuh <thomas@t-8ch.de> wrote:
> >
> > On 2023-04-27 17:17:57-0500, Jorge Lopez wrote:
> > > On Sun, Apr 23, 2023 at 7:16 AM Thomas Weißschuh <thomas@t-8ch.de> wrote:
> > > >
> > > > On 2023-04-20 11:54:52-0500, Jorge Lopez wrote:
> > > > >  .../x86/hp/hp-bioscfg/surestart-attributes.c  | 130 ++++++++++++++++++
> > > > >  1 file changed, 130 insertions(+)
> > > > >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c
> > > > >
> > > > > diff --git a/drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c
> > > > > new file mode 100644

<snip>

> > > > Instead of not returning any data, why not show as many results as
> > > > possible?
> > > >
> > >
> > > if count * LOG_ENTRY_SIZE > PAGE_SIZE then I prefer to return an error.
> > > if the count is correct but a failure occurs while reading individual
> > > audit logs then we will return a partial list of all audit logs
> > > This changes will be included in Version 12
> >
> > What prevents the firmware from having more log entries?
> > Wouldn't these audit log entries not accumulate for each logged
> > operation over the lifetime of the device / boot?
> >
> > This would make the interface unusable as soon as there are more
> > entries.
> 
> BIOS stores a max number of audit logs appropriate to the current
> audit log size.The first audit logs are kept in a FIFO queue by BIOS
> so when the queue is full and a new audit log arrives, then the  first
> audit log will be deleted.

How does it determine "appropriate"?
This would also be great in a comment.

If the BIOS is just using FIFO the driver could return the first
LOG_MAX_ENTRIES entries.
This would avoid trusting the firmware for a reasonable definition of
"appropriate".

> >
> > > > > +
> > > > > +     if (ret < 0)
> > > > > +             return ret;
> >
> > And this should first validate ret and then count.
> 
> Done!
> 
> >
> > > > > +
> > > > > +     /*
> > > > > +      * We are guaranteed the buffer is 4KB so today all the event
> > > > > +      * logs will fit
> > > > > +      */
> > > > > +
> > > > > +     for (i = 0; ((i < count) & (ret >= 0)); i++) {
> > > >
> > > > &&
> > > >
> > > > Better yet, pull the condition ret >= 0 into the body, as an else-branch
> > > > for the existing check.
> > > >
> > >
> > > Done!
> > >
> > > > > +             *buf = (i + 1);
> > > >
> > > > Isn't this directly overwritten by the query below?
> > >
> > > buf input value indicates the audit log to be read hence the reason
> > > why it is overwritten.
> > > This is an expected behavior.
> >
> > So this is read by the HPWMI_SURESTART_GET_LOG method in the firmware?
> >
> > Make sense but need a comment.
> 
> Done!
> 
> >
> > > >
> > > > > +             ret = hp_wmi_perform_query(HPWMI_SURESTART_GET_LOG,
> > > > > +                                        HPWMI_SURESTART,
> > > > > +                                        buf, 1, 128);
> > > > > +             if (ret >= 0)
> > > > > +                     buf += LOG_ENTRY_SIZE;
> > > >
> > > > So 128 bytes are read but only the first 16 bytes are preserved?
> > > >
> > > > The documentation says that each entry has 128 bytes in the file.
> > > > And that they are separated by ";", which is not implemented.
> > >
> > > The statement will be removed from documentation  (separated by ";")
> > > audit log size is 16 bytes.
> > > >
> > > > Can the audit-log not contain all-zero bytes?
> > > > If it does this would need to be a bin_attribute.
> > >
> > > Bytes 16-127 are ignored and not used at this time.  If the audit log
> > > changes, then the driver will need to change to accommodate the new
> > > audit log size.
> >
> > buf is not guaranteed to have 128 bytes left for this data.
> >
> > For example if this is entry number 253 we are at offset 253 * 16 = 4048
> > in the sysfs buffer. Now hw_wmi_perform_query may try to write to 4048 +
> > 127 = 4175 which is out of bounds for the buf of size 4096.
> >
> > Writing first to a stack buffer would be better,
> > or pass outsize = LOG_ENTRY_SIZE.
> >
> BIOS currently stores 16 bytes for each audit log although the WMI
> query reads 128 bytes.  The 128 bytes size is set to provide support
> in future BIOS for audit log sizes >= 16 and < 128 bytes.

And if an old driver is running on a new BIOS then this would write out
of bounds.
Or if the BIOS is buggy.

If the current driver can only handle 16 byte sized log entries then the
this should be used in the call to HPWMI_SURESTART_GET_LOG.

Storing it in a 128 byte stackvariable would also sidestep the issue.
