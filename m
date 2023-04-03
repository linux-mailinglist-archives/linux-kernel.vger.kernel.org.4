Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC206D4EFB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 19:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbjDCRaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 13:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbjDCRaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 13:30:13 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AC9B4;
        Mon,  3 Apr 2023 10:30:10 -0700 (PDT)
Date:   Mon, 3 Apr 2023 17:30:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1680543008; bh=B0pj9cDi6NvqvG3KIfUUAJRoeMd/oY5yI/vrKxSofLI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NFNxEvXAZAUlk5bsrNr4xxkAI03D2xxJOfZqcu6zy1KcCSJAJPm0piCHg6X//ZvzD
         wQz0oYanNLycG6sr72sa0xmChGbMwqlEDsUwuljmOhkZ6PZQcdhKkTdLpLkaMzhdBD
         YaiptmxWjJQf7wW4rHPxPGBK+OI3hD5QCGJlNve4=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Jorge Lopez <jorgealtxwork@gmail.com>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/4] Introduction of HP-BIOSCFG driver [4]
Message-ID: <f68304f0-c533-434d-9f74-92327cd4a002@t-8ch.de>
References: <20230309201022.9502-1-jorge.lopez2@hp.com>
 <20230309201022.9502-5-jorge.lopez2@hp.com>
 <6da33dcc-0526-4398-bf35-655b64d07e20@t-8ch.de>
 <CAOOmCE_kzVnUr9WoPAEu-e+E5=-RfHUCjj6U7kL_yhqKHsP84g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOOmCE_kzVnUr9WoPAEu-e+E5=-RfHUCjj6U7kL_yhqKHsP84g@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jorge,

On 2023-04-03 11:33:20-0500, Jorge Lopez wrote:
> Hi Thomas,
> 
> Please see my comments below.
> 
> On Sat, Apr 1, 2023 at 6:58 AM Thomas Weißschuh <thomas@t-8ch.de> wrote:
> > On 2023-03-09 14:10:22-0600, Jorge Lopez wrote:
> [..]
> > > HP BIOS Configuration driver purpose is to provide a driver supporting
> > > the latest sysfs class firmware attributes framework allowing the user
> > > to change BIOS settings and security solutions on HP Inc.’s commercial
> > > notebooks.
> >
> > Here it says "notebooks", below "PC's". Does it also support
> > non-notebook machines?
> 
> The initial release of the driver will be supported for business notebooks.
> Although the driver is not targeted for non-notebooks machines, the
> driver was tested on non-notebooks in the event a decision is made to
> targets them

If it is not intended to support both, maybe the documentation could
consistently use "notebook".

> > > +             "sure-start"-type specific properties:
> > > +
> > > +             audit_log_entries:
> > > +                                     A read-only file that returns the events in the log.
> > > +
> > > +                                     Audit log entry format
> > > +
> > > +                                     Byte 0-15:   Requested Audit Log entry  (Each Audit log is 16 bytes)
> > > +                                     Byte 16-127: Unused
> > > +
> > > +             audit_log_entry_count:
> > > +                                     A read-only file that returns the number of existing audit log events available to be read.
> > > +
> > > +                                     [No of entries],[log entry size],[Max number of entries supported]
> >
> > sysfs is based on the idea of "one-value-per-file".
> > The two properties above violate this idea.
> > Maybe a different interface is needed.
> >
> 
> Both properties report a single string separated by semicolon.  This
> is not different from listing all elements in a single string
> separated by semicolon.

The documentation does not mention semicolons.

The nice thing about descoping functionality is that we don't need to
worry about their details now.
Instead it can be added later without haste as the core functionality
can already be used by the users.

> > Are these properties very important for the first version of this
> > driver? If not I would propose to drop them for now and resubmit them
> > as separate patches after the main driver has been merged.
> >
> We want the initial driver to have all predefined properties available
> first.   There are plans to add future properties and features which
> will be submitted as patches.

With "properties" do you mean the bios settings?
I agree that all these are good for the initial driver.

But the audit log, detailed error codes, etc... do not seem integral for
the functioning of the driver or for users.

> > > +             HP specific class extensions
> > > +             --------------------------------
> > > +
> > > +What:                /sys/class/firmware-attributes/*/authentication/SPM/kek
> > > +Date:                March 29
> > > +KernelVersion:       5.18
> > > +Contact:     "Jorge Lopez" <jorge.lopez2@hp.com>
> > > +Description: 'kek' is a write-only file that can be used to configure the
> > > +             RSA public key that will be used by the BIOS to verify
> > > +             signatures when setting the signing key.  When written,
> > > +             the bytes should correspond to the KEK certificate
> > > +             (x509 .DER format containing an OU).  The size of the
> > > +             certificate must be less than or equal to 4095 bytes.
> > > +
> > > +
> > > +What:                /sys/class/firmware-attributes/*/authentication/SPM/sk
> > > +Date:                March 29
> > > +KernelVersion:       5.18
> > > +Contact:     "Jorge Lopez" <jorge.lopez2@hp.com>
> > > +Description: 'sk' is a write-only file that can be used to configure the RSA
> > > +             public key that will be used by the BIOS to verify signatures
> > > +             when configuring BIOS settings and security features.  When
> > > +             written, the bytes should correspond to the modulus of the
> > > +             public key.  The exponent is assumed to be 0x10001.
> >
> > The names of the files 'SPM', 'kek' and 'sk' are cryptic.
> 
> SPM - Secure Platform Manager
> kek -  Key-Encryption-Key (KEK)
> sk - Signature Key (SK)
> 
> Those abbreviations were used because they are industry standard and
> reduce the  size of the commands.  Any suggestions?

Maybe mention the long names once in the documentation "Description".

> > > +
> > > +
> > > +What:                /sys/class/firmware-attributes/*/authentication/SPM/status
> > > +Date:                March 29
> > > +KernelVersion:       5.18
> > > +Contact:     "Jorge Lopez" <jorge.lopez2@hp.com>
> > > +Description: 'status' is a read-only file that returns ASCII text reporting
> > > +             the status information.
> > > +
> > > +               State:  Not Provisioned / Provisioned / Provisioning in progress
> > > +               Version:  Major.   Minor
> > > +               Feature Bit Mask: <16-bit unsigned number display in hex>
> > > +               SPM Counter: <16-bit unsigned number display in base 10>
> > > +               Signing Key Public Key Modulus (base64):
> > > +               KEK Public Key Modulus (base64):
> >
> > This also violates 'one-value-per-file'.
> > Can it be split into different files?
> 
> I will split the information in multiple files.
> 
> > This would also remove the need for the statusbin file.
> >
> Status bin is used by GUI applications where data is managed
> accordingly instead of individual lines.

Can the GUI applications not use the split files?

> > For the values:
> >
> > Status: I think symbolic names are better for sysfs:
> >         not_provisioned, provisioned, etc.
> > Feature Bit Mask: Use names.
> > Keys: It would be nicer if these could be shown directly in the files
> >       that can be used to configure them.
> >
> > As before, what is really needed and what can be added later?
> 
> Status is needed when the user enables Secure Platform Manager in BIOS
> and  KEK and/or SK are configured.

Ok.

> >
> > > +
> > > +
> > > +What:                /sys/class/firmware-attributes/*/authentication/SPM/statusbin
> > > +Date:                March 29
> > > +KernelVersion:       5.18
> > > +Contact:     "Jorge Lopez" <jorge.lopez2@hp.com>
> > > +Description: 'statusbin' is a read-only file that returns identical status
> > > +             information reported by 'status' file in binary format.
> >
> > How does this binary format work?
> 
> Yes.  Status bin is used by GUI applications where data is managed
> accordingly instead of individual lines

But this format is not documented here at all.
So how can we determine if the implementation is correct?

> > > +
> > > +
> > > +What:                /sys/class/firmware-attributes/*/attributes/last_error
> > > +Date:                March 29
> > > +KernelVersion:       5.18
> > > +Contact:     "Jorge Lopez" <jorge.lopez2@hp.com>
> > > +Description: 'last_error' is a read-only file that returns WMI error number
> > > +             and message reported by last WMI command.
> >
> > Does this provide much value?
> > Or could this error just be logged via pr_warn_ratelimited()?
> 
> It is specially needed to determine if WMI calls reported an error.
> This property is similar to the one provided by both Dell and Lenovo
> drivers

I don't see similar functionality for the other drivers.
Instead they seem to just return the error codes from the attribute
callbacks.

This may be useful but it does not seem *necessary* for the first
version.


Feel free to only submit the patch with the documentation for the next
revision. Then we can nail down the interface and initial functionality
and you don't always have to adapt the code to the changing interface.

Thomas
