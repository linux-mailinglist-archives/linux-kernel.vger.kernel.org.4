Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E2A656D58
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 18:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbiL0RON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 12:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbiL0ROG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 12:14:06 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81317BF7F;
        Tue, 27 Dec 2022 09:14:00 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id e63fe3dbb9936d4b; Tue, 27 Dec 2022 18:13:58 +0100
Received: from kreacher.localnet (unknown [213.134.183.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 92CD428A349B;
        Tue, 27 Dec 2022 18:13:57 +0100 (CET)
Authentication-Results: v370.home.net.pl; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: v370.home.net.pl; spf=fail smtp.mailfrom=rjwysocki.net
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Pratyush Yadav <ptyadav@amazon.de>, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robert Moore <robert.moore@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@acpica.org
Subject: Re: [PATCH 0/2] intel_pstate: fix turbo not being used after a processor is rebooted
Date:   Tue, 27 Dec 2022 18:13:56 +0100
Message-ID: <12136852.O9o76ZdvQC@kreacher>
In-Reply-To: <CAJZ5v0hFOA97FAq=CwGXgXTkC8aS_vyHjXuaFUppXktrG62H6w@mail.gmail.com>
References: <20221221155203.11347-1-ptyadav@amazon.de> <33dd969d9bdb1eb93f8f2a2167efeb535455cf74.camel@linux.intel.com> <CAJZ5v0hFOA97FAq=CwGXgXTkC8aS_vyHjXuaFUppXktrG62H6w@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.183.5
X-CLIENT-HOSTNAME: 213.134.183.5
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedriedtgdeljecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepvddufedrudefgedrudekfedrheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddukeefrdehpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeduuddprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehpthihrggurghvsegrmhgriihonhdruggvpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhgvnhgssehk
 vghrnhgvlhdrohhrghdprhgtphhtthhopehvihhrvghshhdrkhhumhgrrheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggvvhgvlhesrggtphhitggrrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=11 Fuz1=11 Fuz2=11
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, December 27, 2022 6:02:50 PM CET Rafael J. Wysocki wrote:
> On Tue, Dec 27, 2022 at 5:40 PM srinivas pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> >
> > On Tue, 2022-12-27 at 16:38 +0100, Pratyush Yadav wrote:
> > > Hi Srinivas,
> > >
> > > On Sat, Dec 24 2022, srinivas pandruvada wrote:
> > >
> > > > On Fri, 2022-12-23 at 10:10 -0800, srinivas pandruvada wrote:
> > > > > Hi Pratyush,
> > > > >
> > > > > On Thu, 2022-12-22 at 11:39 +0100, Pratyush Yadav wrote:
> > > > > >
> > > > > > Hi Srinivas,
> > > > > >
> > > > > > On Wed, Dec 21 2022, srinivas pandruvada wrote:
> > > > > > > On Wed, 2022-12-21 at 16:52 +0100, Pratyush Yadav wrote:
> > > > > > > > When a processor is brought offline and online again, it is
> > > > > > > > unable to
> > > > > > > > use Turbo mode because the _PSS table does not contain the
> > > > > > > > whole
> > > > > > > > turbo
> > > > > > > > frequency range, but only +1 MHz above the max non-turbo
> > > > > > > > frequency.
> > > > > > > > This
> > > > > > > > causes problems when ACPI processor driver tries to set
> > > > > > > > frequency
> > > > > > > > constraints. See patch 2 for more details.
> > > > > > > >
> > > > > I can reproduce on a Broadwell server platform. But not on a
> > > > > client
> > > > > system with acpi_ppc usage.
> > > > >
> > > > > Need to check what change broke this.
> > > >
> > > > When PPC limits enforcement changed to PM QOS, this broke.
> > > > Previously
> > > > acpi_processor_get_platform_limit() was not enforcing any limits.
> > > > It
> > > > was just setting variable. So any update done after
> > > > acpi_register_performance_state() call to pr->performance-
> > > > > states[ppc].core_frequency, was effective.
> > > >
> > > > We don't really need to call
> > > >         ret = freq_qos_update_request(&pr->perflib_req,
> > > >                         pr->performance->states[ppc].core_frequency
> > > > *
> > > > 1000);
> > > >
> > > > if the PPC is not changed. When PPC is changed, this gets called
> > > > again,
> > > > so then we can call the above function to update cpufreq limit.
> > > >
> > > > The below change fixed for me.
> > >
> > > Right.
> > I think, this is the only change you require to fix this. In addition
> > set pr->performance_platform_limit = 0 in
> > acpi_processor_unregister_performance().
> 
> Not really, because if the limit is set to a lower frequency and then
> reset to _PSS[0], it needs to be set back to "no limit".
> 
> I'll send a patch for that in a while.

This has not been tested beyond compilation, so please be careful.

---
 drivers/acpi/processor_perflib.c |   27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/acpi/processor_perflib.c
===================================================================
--- linux-pm.orig/drivers/acpi/processor_perflib.c
+++ linux-pm/drivers/acpi/processor_perflib.c
@@ -53,6 +53,8 @@ static int acpi_processor_get_platform_l
 {
 	acpi_status status = 0;
 	unsigned long long ppc = 0;
+	s32 qos_value;
+	int index;
 	int ret;
 
 	if (!pr)
@@ -72,17 +74,30 @@ static int acpi_processor_get_platform_l
 		}
 	}
 
+	index = ppc;
+
+	if (pr->performance_platform_limit == index ||
+	    ppc >= pr->performance->state_count)
+		return 0;
+
 	pr_debug("CPU %d: _PPC is %d - frequency %s limited\n", pr->id,
-		       (int)ppc, ppc ? "" : "not");
+		 index, index ? "is" : "is not");
 
-	pr->performance_platform_limit = (int)ppc;
+	pr->performance_platform_limit = index;
 
-	if (ppc >= pr->performance->state_count ||
-	    unlikely(!freq_qos_request_active(&pr->perflib_req)))
+	if (unlikely(!freq_qos_request_active(&pr->perflib_req)))
 		return 0;
 
-	ret = freq_qos_update_request(&pr->perflib_req,
-			pr->performance->states[ppc].core_frequency * 1000);
+	/*
+	 * If _PPC returns 0, it means that all of the available states can be
+	 * used ("no limit").
+	 */
+	if (index == 0)
+		qos_value = FREQ_QOS_MAX_DEFAULT_VALUE;
+	else
+		qos_value = pr->performance->states[index].core_frequency * 1000;
+
+	ret = freq_qos_update_request(&pr->perflib_req, qos_value);
 	if (ret < 0) {
 		pr_warn("Failed to update perflib freq constraint: CPU%d (%d)\n",
 			pr->id, ret);



