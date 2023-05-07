Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC406F9B90
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 22:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbjEGUi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 16:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjEGUi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 16:38:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 463C66A6D;
        Sun,  7 May 2023 13:38:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 482AE4B3;
        Sun,  7 May 2023 13:39:37 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 914253F663;
        Sun,  7 May 2023 13:38:51 -0700 (PDT)
Date:   Sun, 7 May 2023 21:38:49 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
Cc:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peng Fan <peng.fan@oss.nxp.com>,
        Michal Simek <michal.simek@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        cristian.marussi@arm.com
Subject: Re: [RFC v2 1/3] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Message-ID: <ZFgMWYexdQL5p788@e120937-lin>
References: <cover.1682513390.git.oleksii_moisieiev@epam.com>
 <b4d60f3408f8fe839933fa3938ecdc9bfceb75d7.1682513390.git.oleksii_moisieiev@epam.com>
 <ZFVeY3jVNfAkW1G9@e120937-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFVeY3jVNfAkW1G9@e120937-lin>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2023 at 08:52:03PM +0100, Cristian Marussi wrote:
> On Wed, Apr 26, 2023 at 01:26:37PM +0000, Oleksii Moisieiev wrote:
> > scmi: Introduce pinctrl SCMI protocol driver
> > 
> > Add basic implementation of the SCMI v3.2 pincontrol protocol
> > excluding GPIO support. All pinctrl related callbacks and operations
> > are exposed in the include/linux/scmi_protocol.h
> > 
> 
> Hi Oleksii,

Hi Oleksii,

mostly replying to myself here really (O_o) ... see below.

[snip]

> > +
> > +static int scmi_pinctrl_attributes_get(const struct scmi_protocol_handle *ph,
> > +				       struct scmi_pinctrl_info *pi)
> > +{
> > +	int ret;
> > +	struct scmi_xfer *t;
> > +	struct scmi_msg_pinctrl_protocol_attributes *attr;
> > +
> > +	if (!pi)
> > +		return -EINVAL;
> > +
> > +	ret = ph->xops->xfer_get_init(ph, PROTOCOL_ATTRIBUTES,
> > +				      0, sizeof(*attr), &t);
> > +	if (ret)
> > +		return ret;
> > +
> > +	attr = t->rx.buf;
> > +
> > +	ret = ph->xops->do_xfer(ph, t);
> > +	if (!ret) {
> > +		pi->nr_functions =
> > +			le16_to_cpu(GET_FUNCTIONS_NR(attr->attributes_high));
> > +		pi->nr_groups = le16_to_cpu(GET_GROUPS_NR(attr->attributes_low));
> > +		pi->nr_pins = le16_to_cpu(GET_PINS_NR(attr->attributes_low));
> 
> I see a couple of issues here present in general all across this patch when
> you use these macros;
> 
> You should take care of the endianity in the RX msg payload BEFORE and THEN
> DISSECT the bitfields AND as a consequence use also an _le helper that fits
> the size of the type that you are processing as in (being attributes 32 bit
> little endian in the msg payload):
> 
> 	pi->nr_pins = GET_PINS_NR(le32_to_cpu(attr->attributes_low));
> 
> Now all works just because everything is little endian really so nothing
> is done by these macros....
>

Re-thinking about this, it turns out that the above advice of mine is
just plain wrong :< ... being a bitfield access you cannot do what I
badly advised you:

	GET_PINS_NR(le32_to_cpu(attr->attributes_low));

the right way is indeed how you did it originally...my bad...

... BUT at the same time if you check your original solution:

	le16_to_cpu(GET_FUNCTIONS_NR(attr->attributes_high))

with a static analyzer like sparse, which dutifully checks that __le32
style labeled are accessed in a congruent manner, I get a lot of:

drivers/firmware/arm_scmi/pinctrl.c:136:25: warning: cast to restricted __le32           
drivers/firmware/arm_scmi/pinctrl.c:136:25: warning: restricted __le32 degrades to integer
drivers/firmware/arm_scmi/pinctrl.c:136:25: warning: restricted __le32 degrades to integer
drivers/firmware/arm_scmi/pinctrl.c:136:25: warning: cast to restricted __le16          

with your original solution and no errors with my broken proposal... :O

...this is due to the fact that indeed FIELD_GET & C. are not meant to
be used on such __le32 endian-styled vars, so sparse warns you about that
(but my bad advice remain broken even though fine for the static analyzer...)

Digging into bitfield.h, indeed, turns out that near the end, there are
defined some LE dedicated bitfield macros (https://lwn.net/Articles/741762/)
like:

	u32 le32_get_bits(__le32 val, u32 field)

So you can just convert your macros to use le32_get_bits (insted of FIELD_GET) and
use those macros directly without the need for the additional le32_to_cpu conversion
as in the example below. (that indeed gives me no more sparse errors)

Hope not to have made to much noise :P

Thanks,
Cristian

P.S.: I would also drop the RFC on V3 so that maybe a few more public check-bots
will engage with your series


->8---

diff --git a/drivers/firmware/arm_scmi/pinctrl.c b/drivers/firmware/arm_scmi/pinctrl.c
index 1392d15b3a58..66ea51606f46 100644
--- a/drivers/firmware/arm_scmi/pinctrl.c
+++ b/drivers/firmware/arm_scmi/pinctrl.c
@@ -14,15 +14,15 @@
 #define REG_TYPE_BITS GENMASK(9, 8)
 #define REG_CONFIG GENMASK(7, 0)
 
-#define GET_GROUPS_NR(x) FIELD_GET(GENMASK(31, 16), (x))
-#define GET_PINS_NR(x) FIELD_GET(GENMASK(15, 0), (x))
-#define GET_FUNCTIONS_NR(x) FIELD_GET(GENMASK(15, 0), (x))
+#define GET_GROUPS_NR(x)       le32_get_bits((x), GENMASK(31, 16))
+#define GET_PINS_NR(x)         le32_get_bits((x), GENMASK(15, 0))
+#define GET_FUNCTIONS_NR(x)    le32_get_bits((x), GENMASK(15, 0))
 
-#define EXT_NAME_FLAG(x) FIELD_GET(BIT(31), (x))
-#define NUM_ELEMS(x) FIELD_GET(GENMASK(15, 0), (x))
+#define EXT_NAME_FLAG(x)       le32_get_bits((x), BIT(31))
+#define NUM_ELEMS(x)           le32_get_bits((x) ,GENMASK(15, 0))
 
-#define REMAINING(x) FIELD_GET(GENMASK(31, 16), (x))
-#define RETURNED(x) FIELD_GET(GENMASK(11, 0), (x))
+#define REMAINING(x)           le32_get_bits((x), GENMASK(31, 16))
+#define RETURNED(x)            le32_get_bits((x), GENMASK(11, 0))
 
 enum scmi_pinctrl_protocol_cmd {
        PINCTRL_ATTRIBUTES = 0x3,
@@ -132,10 +132,9 @@ static int scmi_pinctrl_attributes_get(const struct scmi_protocol_handle *ph,
 
        ret = ph->xops->do_xfer(ph, t);
        if (!ret) {
-               pi->nr_functions =
-                       le16_to_cpu(GET_FUNCTIONS_NR(attr->attributes_high));
-               pi->nr_groups = le16_to_cpu(GET_GROUPS_NR(attr->attributes_low));
-               pi->nr_pins = le16_to_cpu(GET_PINS_NR(attr->attributes_low));
+               pi->nr_functions = GET_FUNCTIONS_NR(attr->attributes_high);
+               pi->nr_groups = GET_GROUPS_NR(attr->attributes_low);
+               pi->nr_pins = GET_PINS_NR(attr->attributes_low);
        }
 
        ph->xops->xfer_put(ph, t);
@@ -209,7 +208,7 @@ static int scmi_pinctrl_attributes(const struct scmi_protocol_handle *ph,
        ret = ph->xops->do_xfer(ph, t);
        if (!ret) {
                if (n_elems)
-                       *n_elems = le32_to_cpu(NUM_ELEMS(rx->attributes));
+                       *n_elems = NUM_ELEMS(rx->attributes);
                strscpy(name, rx->name, SCMI_SHORT_NAME_MAX_SIZE);
        }
 
@@ -253,8 +252,8 @@ static int iter_pinctrl_assoc_update_state(struct scmi_iterator_state *st,
 {
        const struct scmi_resp_pinctrl_list_assoc *r = response;
 
-       st->num_returned = le32_to_cpu(RETURNED(r->flags));
-       st->num_remaining = le32_to_cpu(REMAINING(r->flags));
+       st->num_returned = RETURNED(r->flags);
+       st->num_remaining = REMAINING(r->flags);
 
        return 0;
 }

-8<---

