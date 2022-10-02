Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD715F274E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 01:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiJBX7O convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 2 Oct 2022 19:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJBX7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 19:59:11 -0400
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1BC1CB39;
        Sun,  2 Oct 2022 16:59:10 -0700 (PDT)
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay01.hostedemail.com (Postfix) with ESMTP id 0CDBB1C5CFB;
        Sun,  2 Oct 2022 23:59:08 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf05.hostedemail.com (Postfix) with ESMTPA id B1DD92000E;
        Sun,  2 Oct 2022 23:58:43 +0000 (UTC)
Message-ID: <c9cc8511a4aa409407dce23719418140b66cdf47.camel@perches.com>
Subject: Re: [PATCH v4 10/14] gunyah: sysfs: Add node to describe supported
 features
From:   Joe Perches <joe@perches.com>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 02 Oct 2022 16:58:59 -0700
In-Reply-To: <1f599b97-9242-3844-4372-1610948f4baf@quicinc.com>
References: <20220928195633.2348848-1-quic_eberman@quicinc.com>
         <20220928195633.2348848-11-quic_eberman@quicinc.com>
         <3c02aad6d8bde70964b403a3cb8004de969becc6.camel@perches.com>
         <1f599b97-9242-3844-4372-1610948f4baf@quicinc.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: B1DD92000E
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        KHOP_HELO_FCRDNS,SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Stat-Signature: bxo4uofuiuh44az86fsxqtaeyj75n91x
X-Rspamd-Server: rspamout07
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/LAwYOxWYuUHOFlw80rjQndZ2p3aMK5A8=
X-HE-Tag: 1664755123-277924
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-10-02 at 16:30 -0700, Jeff Johnson wrote:
> On 9/29/2022 12:36 AM, Joe Perches wrote:
> > On Wed, 2022-09-28 at 12:56 -0700, Elliot Berman wrote:
> > > Add a sysfs node to list the features that the Gunyah hypervisor and
> > > Linux supports. For now, Linux support cspace (capability IDs) and
> > > message queues, so only report those..
> > []
> > > diff --git a/drivers/virt/gunyah/sysfs.c b/drivers/virt/gunyah/sysfs.c
> > []
> > > @@ -25,9 +25,24 @@ static ssize_t variant_show(struct kobject *kobj, struct kobj_attribute *attr, c
> > >   }
> > >   static struct kobj_attribute variant_attr = __ATTR_RO(variant);
> > >   
> > > +static ssize_t features_show(struct kobject *kobj, struct kobj_attribute *attr, char *buffer)
> > > +{
> > > +	int len = 0;
> > > +
> > > +	if (GH_IDENTIFY_PARTITION_CSPACE(gunyah_api.flags))
> > > +		len += sysfs_emit_at(buffer, len, "cspace ");
> > > +	if (GH_IDENTIFY_MSGQUEUE(gunyah_api.flags))
> > > +		len += sysfs_emit_at(buffer, len, "message-queue ");
> > > +
> > > +	len += sysfs_emit_at(buffer, len, "\n");
> > > +	return len;
> > > +}
> > 
> > It's generally nicer to avoid unnecessary output spaces.
> > 
> > Perhaps:
> > 
> > {
> > 	int len = 0;
> > 
> > 	if (GH_IDENTIFY_PARTITION_CSPACE(gunyah_api.flags))
> > 		len += sysfs_emit_at(buffer, len, "cspace");
> > 	if (GH_IDENTIFY_MSGQUEUE(gunyah_api.flags)) {
> > 		if (len)
> > 			len += sysfs_emit_at(buffer, len, " ");
> > 		len += sysfs_emit_at(buffer, len, "message-queue");
> > 	}
> > 
> > 	len += sysfs_emit_at(buffer, len, "\n");
> > 
> > 	return len;
> > }
> > 
> 
> that approach seems ok for 2 features, but imo doesn't scale for more.
> I like the original code with one exception:
> 
> 	if (GH_IDENTIFY_PARTITION_CSPACE(gunyah_api.flags))
> 		len += sysfs_emit_at(buffer, len, "cspace ");
> 	if (GH_IDENTIFY_MSGQUEUE(gunyah_api.flags))
> 		len += sysfs_emit_at(buffer, len, "message-queue ");
> 
> 	/* overwrite last trailing space */
> 	if (len)
> 		len--;
> 
> 	len += sysfs_emit_at(buffer, len, "\n");
> 	return len;
> 

That's fine as long as every formatted output uses a trailing space.

A trivial negative would be that the linker would generally not be
able to deduplicate these output strings with trailing spaces across
the entire codebase.

