Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87D366BDF0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 13:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjAPMgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 07:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbjAPMgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 07:36:15 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3AAD1E28B
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:36:11 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id q5so2799209pjh.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yhZq016h8NHtg/aYhyi4C3y/4JnP8MH7Vr54eBiXz8o=;
        b=wj79cgu2X88gTjG33E3Y+X875nfUCtLHBge1igOPGOtTbEm8lWm8E+UIFm94pMDmh6
         KmgnDvMAaiBxvdTmaUqealgAXEueN/rSmpyJdzr3vrCumOhFtwQctq/fHDAGvVb0Pthz
         9yqn9b+z2M0O0mHVTCjNYsHtIFhpiUMN3qtp2wWIb+3s+YEJYy4K0wE/+3bOaBwL8Dkc
         vZVupA8bxa14D1B46xSaVxicw+2egIf4V2j/FOYnhjgsq+5tXMq2Doj374ue0u84HHNV
         u3lcHWQfbyS5x9a0v82K/aF3RZQrXZVkCRaX2w6TP8VQ6OaPy6yf2ClPgq8O8JY/U/qz
         38Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yhZq016h8NHtg/aYhyi4C3y/4JnP8MH7Vr54eBiXz8o=;
        b=2FJeu3hYA/g/15aM+beQf0K37Mp6vRE43WCfNR1k5IKaizOMCo6q6MhJGbAuut9K0r
         EU09nerBO2B5cE5b89RAMQyB36FzLScq3ViiUlfcLzKqSrJ4OqFzU71+cda/obEQ1Y5s
         ScXJgkxalTOXfSZUW+7N8kALUh2g0MWeF5DkGqcgqllb7FD/b/4Xy8rulhp66gYl33Yl
         X135CpPBBtC2sUv9nUUfu9BC97LAtoDWGspjxIE3J3dmhYvGDIrzHEI9He8NzlP3Z0B/
         HHsUSoZ1NaHEW3JbA0ZMSZO76jGQb7aMb6LnZhc5kfmwz1kHPaAaqQ2RevKmoYt+99NN
         9xXg==
X-Gm-Message-State: AFqh2kqpUclDl7Djo8qCqiihc0TIMD6Nr4EtOuW0jSeh2wo+WHn7kr0k
        c4B3dTheWI1weNChlpAgf8lnv5M1dHZ5r195Ccu/Zg==
X-Google-Smtp-Source: AMrXdXsecdek3NYqCMhbMrfNLcvTUdIJGigxEdIJSe6swGodXIwP7WsYebHt0ULv29knbWQKkGpOJO+VBOPXF0dlUHM=
X-Received: by 2002:a17:90b:b03:b0:229:229b:9ff6 with SMTP id
 bf3-20020a17090b0b0300b00229229b9ff6mr1014935pjb.87.1673872571159; Mon, 16
 Jan 2023 04:36:11 -0800 (PST)
MIME-Version: 1.0
References: <20221219234638.3661-1-mike.leach@linaro.org> <20221219234638.3661-4-mike.leach@linaro.org>
 <Y6sm1gXTER/XaggE@infradead.org>
In-Reply-To: <Y6sm1gXTER/XaggE@infradead.org>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Mon, 16 Jan 2023 12:36:00 +0000
Message-ID: <CAJ9a7Vh-zhfiM=ERXPfQ3yN3zLHbRzfnG7MZt0FO56VkQNUJFw@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] coresight: configfs: Add in binary attributes to
 load files
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        suzuki.poulose@arm.com, acme@kernel.org, james.clark@arm.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph

On Tue, 27 Dec 2022 at 17:09, Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Dec 19, 2022 at 11:46:35PM +0000, Mike Leach wrote:
> > Add in functionality and binary attribute to load and unload
> > configurations as binary data.
> >
> > Files are loaded via the 'load' binary attribute. System reads the incoming
> > file, which must be formatted correctly as defined in the file reader code.
> > This will create configuration(s) and/or feature(s) and load them
> > into the system.
>
> Binary attributes are intended to pass things such as firmware
> through.  Defining your own structured file format seems like a
> major abuse of the configfs design.  What's the advantage of this
> over simply using an ioctl?

The coresight configurations loaded here, represent programming of the
entire coresight subsystem - possibly tens of registers (especially on
the ETM), across multiple devices, in ways that are not possible using
the limited parameters of the perf command line.

The ETM can be programmed in ways that use counters. sequencers, and
optionally interact with other components such as CTI / CTM to send
conditional hardware triggers, all of which control the when and how
the trace is collected. Additionally there are system trace components
that might need to run at the same time - such as ELA, and other
system monitors that output data on the trace bus currently being
introduce by some chip designers.

As such the configuration must be loaded into the coresight system as
a single operation - with the individual drivers validating the
requested programming, where any error will fail the configuration
load. The individual drivers are also responsible for defining which
device registers user configurations can use - these being limited to
those that affect the scope of trace collected, with other operational
functions being reserved to the drivers themselves.

To achieve this a variable sized table of programming descriptors is
defined, that are transferred into the individual devices. The very
limited set of built in configurations - where the programming
descriptors are compiled into the driver modules themselves use the
same set of descriptors. however, recompiling kernel modules to
program new configurations is neither scaleable, flexible or desirable
- so we need a way of loading configurations at runtime. So the file
structure is simple a serialisation of these descriptor tables - with
a header defining the input type and overall size..

The advantage of these runtime configurations is that they can be
portable - and dependent on the hardware in the system, not the kernel
build version. Moreover, there are trace scenarios when we want to
trace what is present, not recompile a module / kernel to achieve
this, especially investigating issues on production systems.

1) using configfs to load these configurations keeps all the coresight
configuration ABI in a single file system - configfs. The current
builtin configurations can be viewed, enabled,  and parameters
configrured in the current configfs that we have upstreamed. Adding
load / unload here is a logical extension of this.

2) because of the nature of configurations described above - we would
need a separate device to represent the whole subsystem - in order to
provide the ioctl support for loading. This device approach to
managing configurations has been previously rejected by the Coresight
maintainers, who suggested that configfs was the correct way to
configure a complex sub-system.

3) configurations are variable in size, An ioctl command would provide
a pointer to the configuration data - but the kernel would have to
trust that the underlying data is correctly formed. With a configfs
file write we get the buffer _and_ its size which is a good deal safer
from an input perspective.

4) ioctl use would require a loader program - configfs allows load
directly from the command line.

I agree that ioctls certainly have there uses, especially with small,
fixed size data types - but configfs is far better suited to this
complex use case.
Indeed the ioctl documentation suggests using configfs for
configuration cases that are too complex for sysfs, when an ioctl may
not be suitable.

This use of binary attributes is based on the existing use of a
configfs binary attribute is for the ACPI tables - the ACPI driver
here takes the buffer, does some initial validation of the file size
etc, then calls the inslall ./ validate ACPI routines where the table
is added to an internal list of tables maintained by the kernel. These
tables may well be shared by firmware - but are also used by the
kernel.

There appears to be nothing in the configfs documentation limiting the
use of binary attributes for passing firmware, Even the sysfs docs
suggest that this is an expected use but it is not a hard and fast
rule if there are no alternatives.
Granted in the vast majority of cases there are better alternatives.

I believe that loading via configfs is the best and safest engineering
solution for this particular use case.

Regards

Mike

--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
