Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5F367C7AB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 10:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236549AbjAZJnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 04:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbjAZJnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 04:43:50 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E16FCC10;
        Thu, 26 Jan 2023 01:43:49 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D50394B3;
        Thu, 26 Jan 2023 01:44:30 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C6F53F71E;
        Thu, 26 Jan 2023 01:43:47 -0800 (PST)
Date:   Thu, 26 Jan 2023 09:43:44 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: firmware: arm,scmi: Restrict protocol child
 node properties
Message-ID: <Y9JLUIioxFPn4BS0@e120937-lin>
References: <20230124222023.316089-1-robh@kernel.org>
 <Y9EyB+OO7MyGy20w@e120937-lin>
 <20230125141113.kkbowopusikuogx6@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125141113.kkbowopusikuogx6@bogus>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 02:11:13PM +0000, Sudeep Holla wrote:
> On Wed, Jan 25, 2023 at 01:43:48PM +0000, Cristian Marussi wrote:
> > so now that the catch-all protocol@ patternProperty is gone in favour
> > of the 'protocol-node' definition and $refs, does that mean that any
> > current and future SCMI officially published protocol <N> has to be
> > added to the above explicit protocol list, even though it does not
> > have any special additional required property beside reg ?
> > (like protocol@18 above...)
> >
> 
> If there are no consumers, should we just not add and deal with it
> entirely within the kernel. I know we rely today on presence of node
> before we initialise, but hey we have exception for system power protocol
> for other reasons, why not add this one too.
> 
> In short we shouldn't have to add a node if there are no consumers. It
> was one of the topic of discussion initially when SCMI binding was added
> and they exist only for the consumers otherwise we don't need it as
> everything is discoverable from the interface.

It is fine for me the no-consumers/no-node argument (which anyway would
require a few changes in the core init logic anyway to work this way...),
BUT is it not that ANY protocol (even future-ones) does have, potentially,
consumers indeed, since each protocol-node can potentially have a dedicated
channel and related DT channel-descriptor ? (when multiple channels are
allowed by the transport)

I mean, as an example, you dont strictly need protos 0x18/0x12 nodes for
anything (if we patch the core init as said) UNLESS you want to dedicate
a channel to those protocols; so I'm just checking here if these kind of
scenarios will still be allowed with this binding change, or if I am
missing something.

Thanks,
Cristian

