Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E8D6F3F4B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 10:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbjEBIii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 04:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233805AbjEBIig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 04:38:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A1F010B;
        Tue,  2 May 2023 01:38:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0761C4B3;
        Tue,  2 May 2023 01:39:18 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B538A3F5A1;
        Tue,  2 May 2023 01:38:31 -0700 (PDT)
Date:   Tue, 2 May 2023 09:38:29 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Johan Hovold <johan@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/4] dt-bindings: firmware: Add Qualcomm QSEECOM
 interface
Message-ID: <20230502083829.qetjuvoilows26m7@bogus>
References: <20230305022119.1331495-1-luzmaximilian@gmail.com>
 <20230305022119.1331495-4-luzmaximilian@gmail.com>
 <20230308221657.GA3935330-robh@kernel.org>
 <93657561-d545-7ead-7f6c-dd2c62aab319@gmail.com>
 <c92a44fe-7057-2d81-41fc-2e84ae60f881@linaro.org>
 <951c717b-d094-4190-a04b-3ce9007d1554@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <951c717b-d094-4190-a04b-3ce9007d1554@gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 03:27:01AM +0100, Maximilian Luz wrote:
> On 3/9/23 02:33, Dmitry Baryshkov wrote:
> > On 09/03/2023 00:44, Maximilian Luz wrote:
> > > On 3/8/23 23:16, Rob Herring wrote:
> > > > On Sun, Mar 05, 2023 at 03:21:18AM +0100, Maximilian Luz wrote:
> > > > > Add bindings for the Qualcomm Secure Execution Environment interface
> > > > > (QSEECOM).
> > > > 
> > > > Pretty sure I already asked, but no answer in the commit message. Why do
> > > > we need this? You've already declared the platform supports SCM calls
> > > > with "qcom,scm". Why can't you probe whether you have QSEECOM or not? DT
> > > > is for non-discoverable h/w we are stuck with.
> > > 
> > > Yes, you've asked this before but I can only repeat what I've written in
> > > my last response to your question: I am not aware of any way to properly
> > > discover the interface at runtime from software.
> > > 
> > > If it makes you happy, I can put this in the commit message as well...
> > > 
> > > > Why is software made non-discoverable too?
> > > 
> > > Please direct that question at the Qualcomm guys who actually designed
> > > that interface. I can't give you an answer to that, and I'm not all that
> > > happy about this either.
> > > 
> > > To reiterate: I've reverse engineered this based on the Windows driver.
> > > The Windows driver loads on an ACPI HID and it doesn't use any function
> > > to check/verify whether the interface is actually present. Adding a DT
> > > entry is the straight-forward adaption to having a HID in ACPI.
> > > 
> > > > Nodes with only a compatible string are usually just an abuse of DT to
> > > > instantiate some driver.
> > > 
> > > If you or anyone here has any idea on how to discover the presence of
> > > this, please feel free to let me know and I'd be happy to implement
> > > that. Until then, I unfortunately don't see any other way of dealing
> > > with this.
> > 
> > You can probably try requesting QSEECOM version. According to msm-3.18:
> > 
> >          uint32_t feature = 10;
> > 
> >          rc = qseecom_scm_call(6, 3, &feature, sizeof(feature),
> >                  &resp, sizeof(resp));
> >          pr_info("qseecom.qsee_version = 0x%x\n", resp.result);
> >          if (rc) {
> >                  pr_err("Failed to get QSEE version info %d\n", rc);
> >                  goto exit_del_cdev;
> >          }
> > 
> 
> Thanks! I'll give that a try.
> 
> As I can't test this on a device that doesn't have qseecom, it would
> probably be a good idea if someone could test this on a device that has
> qcom_scm but no qseecom (if those even exist) to make sure this doesn't
> misbehave.
> 

TBH, this has been going in round for quite sometime. We have been asking
you to depend on existing platform compatible + a query or a check on the
version. Since you do have a platform that is working, we can start making
it min "qseecom.qsee_version" supported and then adjust the version based
on the testing or the requirement. What do you think ?

-- 
Regards,
Sudeep
