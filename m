Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3DF679E2A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 17:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbjAXQFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 11:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbjAXQFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 11:05:35 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0656246D7B;
        Tue, 24 Jan 2023 08:05:35 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1112)
        id C071A20E2D34; Tue, 24 Jan 2023 08:05:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C071A20E2D34
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1674576334;
        bh=i5g/IYkkyKRLGzIOTU8BqfMo6JalaclIrWBhXpBfn+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hZ7fa/WyHMIaCOR1Qr5AJaJM6dY/KGah7620BW65sqygzZyBMZPtOIGVIg5SmWb5T
         /N2CY524kmBbwyz/18lS6f5NHQd5DfW3Wwd2PZ7yTEFvH4DdCRMF4Xxa9q+Npo3VPX
         SBCaFflRc1XvlyLUdEZO8FYkha4pRHbXYJbUpj9M=
Date:   Tue, 24 Jan 2023 08:05:34 -0800
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v1 1/8] include/acpi: add definition of ASPT table
Message-ID: <20230124160534.GA28153@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20230123152250.26413-1-jpiotrowski@linux.microsoft.com>
 <20230123152250.26413-2-jpiotrowski@linux.microsoft.com>
 <CAJZ5v0i=NDrHAQYQPfvBGvkvBzNnDhUxxPivQ1VaZ8HBhAyS0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i=NDrHAQYQPfvBGvkvBzNnDhUxxPivQ1VaZ8HBhAyS0A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 08:56:32PM +0100, Rafael J. Wysocki wrote:
> On Mon, Jan 23, 2023 at 4:23 PM Jeremi Piotrowski
> <jpiotrowski@linux.microsoft.com> wrote:
> >
> > The AMD Secure Processor ACPI Table provides the memory location of the
> > register window and register offsets necessary to communicate with AMD's
> > PSP (Platform Security Processor). This table is exposed on Hyper-V VMs
> > configured with support for AMD's SNP isolation technology.
> >
> > Signed-off-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
> 
> This modifies the ACPICA code, so it should at least be submitted as a
> pull request to the upstream ACPICA project on GitHub.
> 
> Thanks!

Hi Rafael,

Sorry, missed that part of the documentation. Here's the PR:
https://github.com/acpica/acpica/pull/829

Thanks,
Jeremi

> 
> > ---
> >  include/acpi/actbl1.h | 46 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 46 insertions(+)
> >
> > diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> > index 15c78678c5d3..00d40373df37 100644
> > --- a/include/acpi/actbl1.h
> > +++ b/include/acpi/actbl1.h
> > @@ -26,6 +26,7 @@
> >   */
> >  #define ACPI_SIG_AEST           "AEST" /* Arm Error Source Table */
> >  #define ACPI_SIG_ASF            "ASF!" /* Alert Standard Format table */
> > +#define ACPI_SIG_ASPT           "ASPT" /* AMD Secure Processor Table */
> >  #define ACPI_SIG_BERT           "BERT" /* Boot Error Record Table */
> >  #define ACPI_SIG_BGRT           "BGRT" /* Boot Graphics Resource Table */
> >  #define ACPI_SIG_BOOT           "BOOT" /* Simple Boot Flag Table */
> > @@ -106,6 +107,51 @@ struct acpi_whea_header {
> >         u64 mask;               /* Bitmask required for this register instruction */
> >  };
> >
> > +/* https://docs.microsoft.com/en-us/windows-hardware/drivers/ddi/acpitabl/ns-acpitabl-aspt_table */
> > +#define ASPT_REVISION_ID 0x01
> > +struct acpi_table_aspt {
> > +       struct acpi_table_header header;
> > +       u32 num_entries;
> > +};
> > +
> > +struct acpi_aspt_header {
> > +       u16 type;
> > +       u16 length;
> > +};
> > +
> > +enum acpi_aspt_type {
> > +       ACPI_ASPT_TYPE_GLOBAL_REGS = 0,
> > +       ACPI_ASPT_TYPE_SEV_MBOX_REGS = 1,
> > +       ACPI_ASPT_TYPE_ACPI_MBOX_REGS = 2,
> > +};
> > +
> > +/* 0: ASPT Global Registers */
> > +struct acpi_aspt_global_regs {
> > +       struct acpi_aspt_header header;
> > +       u32 reserved;
> > +       u64 feature_reg_addr;
> > +       u64 irq_en_reg_addr;
> > +       u64 irq_st_reg_addr;
> > +};
> > +
> > +/* 1: ASPT SEV Mailbox Registers */
> > +struct acpi_aspt_sev_mbox_regs {
> > +       struct acpi_aspt_header header;
> > +       u8 mbox_irq_id;
> > +       u8 reserved[3];
> > +       u64 cmd_resp_reg_addr;
> > +       u64 cmd_buf_lo_reg_addr;
> > +       u64 cmd_buf_hi_reg_addr;
> > +};
> > +
> > +/* 2: ASPT ACPI Mailbox Registers */
> > +struct acpi_aspt_acpi_mbox_regs {
> > +       struct acpi_aspt_header header;
> > +       u32 reserved1;
> > +       u64 cmd_resp_reg_addr;
> > +       u64 reserved2[2];
> > +};
> > +
> >  /*******************************************************************************
> >   *
> >   * ASF - Alert Standard Format table (Signature "ASF!")
> > --
> > 2.25.1
> >
