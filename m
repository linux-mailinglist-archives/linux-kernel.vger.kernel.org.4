Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B362174D41C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 13:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbjGJLDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 07:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbjGJLCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 07:02:54 -0400
Received: from blizzard.enjellic.com (wind.enjellic.com [76.10.64.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E391DB;
        Mon, 10 Jul 2023 04:02:53 -0700 (PDT)
Received: from blizzard.enjellic.com (localhost [127.0.0.1])
        by blizzard.enjellic.com (8.15.2/8.15.2) with ESMTP id 36AANK8q019739;
        Mon, 10 Jul 2023 05:23:20 -0500
Received: (from greg@localhost)
        by blizzard.enjellic.com (8.15.2/8.15.2/Submit) id 36AANJlv019737;
        Mon, 10 Jul 2023 05:23:19 -0500
X-Authentication-Warning: blizzard.enjellic.com: greg set sender to greg@enjellic.com using -f
From:   "Dr. Greg" <greg@enjellic.com>
To:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net
Subject: [PATCH 00/13] Implement Trusted Security Event Modeling.
Date:   Mon, 10 Jul 2023 05:23:06 -0500
Message-Id: <20230710102319.19716-1-greg@enjellic.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning, I hope this note finds the week starting well for
everyone.

This is the second release of a patch series that implements
Trusted Security Event Modeling (TSEM) as a new Linux Security
Module (LSM) architecture.

TSEM provides kernel infrastructure for implementing security
controls based on either deterministic or machine learning
models.  It also provides a framework for implementing Host Based
Intrusion Detection (HIDS) and/or anomaly detection architectures
without the need to write kernel code or implement kernel
modules.

TSEM is designed to support the concept of a Trust Orchestration
System (TOS).  Trust orchestration involves the process of
modeling the security behavior of a workload, or a platform at
large, and defining whether or not a process is to be trusted,
based on whether or not the security events produced are
consistent with a security model that has been unit tested for a
workload or platform.

TSEM operates under the premise, that security, like all other
physical phenomena in science and engineering, can be
mathematically modeled.  TSEM notionally treats the LSM security
event hooks as a basis set of parameters that are capable of
generating a functional value for the security state of a system.

TSEM, in and of itself, does not implement security policy.  That
capability is invested in an entity known as a Trusted Modeling
Agent (TMA).  A TMA can be implemented in the kernel itself or
the security event descriptions can be exported to userspace for
processing in a non-kernel based TMA.

To support this architecture, TSEM implements entirely within the
context of the LSM architecture, the concept of security modeling
namespaces that are akin to other resource namespaces.  A
security modeling namespace is paired with a TMA that implements
the root of trust for a security modeling namespace.

A TMA implementation uses the characteristics of the calling
process and the descriptive parameters of a security event to
compute coefficients for each security event that occurs in a
security modeling namespace.  The sum of these coefficients,
represents the security 'state' of the model.

TSEM supports any number of security modeling namespaces that act
independently of one another and of the root security modeling
namespace.  Each namespace can be configured with its own unique
security model definition that can be configured to be modeled
internally or externally.  The cryptographic hash function used
to generate the security state coefficients can be configured at
the namespace level as can the source of resolution for UID/GID
values.

Security models to be enforced by a trust orchestrator in a
security modeling namespace are developed by unit testing of a
workload.  These security models are designed to be distributed
as a manifest that defines the desired security behavior of a
workload.

TSEM represents a security architecture that is designed to be
driven by modern software development strategies that embrace
resource containerization and continuous integration and delivery
principles.  The objective of TSEM, along with the Quixote TOS
implementation, is to bring to Linux security architecture what
Docker brought to Linux resource namespaces.

Included in the patch series is an extensive documentation file that
can be found in the following location after the series is applied:

Documentation/admin-guide/LSM/tsem.rst

Reviewers, and others who are interested, are referred to this
document for a more extensive discussion into the rationale,
design and implementation of the TSEM architecture.

Control of TSEM is surfaced entirely in the securityfs filesystem
through the following directory heirarchy:

/sys/kernel/security/tsem

TSEM is designed to be largely self-contained and independent of
the kernel at large and with other LSM's with which it stacks.
It operates without the need for filesystem labeling or
cryptographic integrity protection of filesystem metadata.

The TSEM in-kernel TMA implements a very simple deterministic
security model.  Moving forward, the TSEM architecture is
designed to provide a flexible framework to support the
implementation of more advanced models that use stochastics,
inference and generative machine learning.

Version 1.5 of the Quixote userspace utilities that support this
TSEM kernel release can be obtained from the following URL:

ftp://ftp.enjellic.com/pub/Quixote

In addition to source there is a binary utility package that has
been compiled and statically linked with MUSL libc that should
install and run, without dependencies, on any TSEM enabled
kernel.

Included are implementations of trust orchestrator's for the
following TMA trust roots:

Kernel.

Userspace process.

SGX enclave.

Xen hypervisor stub-domain.

Hardware based security coprocessors.

Among the objectives of Quixote/TSEM is to provide a framework
for developing next generation hardware assisted security
co-processor technology that extends beyond what is currently
represented in the form of Trusted Platform Modules.

Included with the Quixote TOS is an implementation of a security
co-processor based on the Nordic NRF52840-DONGLE
micro-controller.  This is a 32-bit ARM based USB form factor
device that is currently being used for projects such as GOOGLE's
OpenSK security key initiative and 3mdeb's Fobnail attestation
server project.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity

V1:
- Initial release.	  

V2:
- V1: https://lore.kernel.org/linux-security-module/20230204050954.11583-1-greg@enjellic.com/T/#t
- Allow compile time configuration of the Platform Configuration
  Register used to extend security coefficients in the root
  security modeling namespace.
- Allow both internal and external modeling of security events
  that are called in atomic context.
- Use JSON to encode security event characteristics.
- Use securityfs for TSEM control plane rooted at
  /sys/kernel/security/tsem.
- Use framework of separate directories for internal TMA's to
  protect ABI compatability.
- Use key=value arguments for control plane commands.
- Allow cryptographic hash function used for coefficient
  generation to be configured on a namespace by namespace basis.
- Allow selection of initial or current user namespace as the
  reference for UID/GID resolution to be configured on a namespace
  by namespace basis.
- Allow the size of modeling and export structures to be configured
  on a namespace by namespace basis.
- Extensively document all globally visible enumerations and structures.
- Use CAP_ML rather than CAP_TRUST for modeling capability bit.
- Implement orchestrator<->process mutual authentication.
- Implement occupancy counts for security state coefficients.
- Move TSEM to the first LSM in the LSM list.

Dr. Greg (13):
  Update MAINTAINERS file.
  Add TSEM specific documentation.
  Implement CAP_TRUST capability.
  Add TSEM master header file.
  Add primary TSEM implementation file.
  Add root domain trust implementation.
  Implement TSEM control plane.
  Add namespace implementation.
  Add security event description export facility.
  Add event description implementation.
  Implement security event mapping.
  Implement an internal Trusted Modeling Agent.
  Activate the configuration and build of the TSEM LSM.

 Documentation/ABI/testing/tsem                |  828 +++++++
 Documentation/admin-guide/LSM/index.rst       |    1 +
 Documentation/admin-guide/LSM/tsem.rst        | 1526 +++++++++++++
 .../admin-guide/kernel-parameters.txt         |   18 +
 MAINTAINERS                                   |    8 +
 include/uapi/linux/capability.h               |    6 +-
 security/Kconfig                              |   11 +-
 security/Makefile                             |    1 +
 security/selinux/include/classmap.h           |    2 +-
 security/tsem/Kconfig                         |   36 +
 security/tsem/Makefile                        |    2 +
 security/tsem/event.c                         |  669 ++++++
 security/tsem/export.c                        |  394 ++++
 security/tsem/fs.c                            | 1336 +++++++++++
 security/tsem/map.c                           |  531 +++++
 security/tsem/model.c                         |  714 ++++++
 security/tsem/namespace.c                     |  347 +++
 security/tsem/trust.c                         |  220 ++
 security/tsem/tsem.c                          | 1987 +++++++++++++++++
 security/tsem/tsem.h                          | 1516 +++++++++++++
 20 files changed, 10146 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/ABI/testing/tsem
 create mode 100644 Documentation/admin-guide/LSM/tsem.rst
 create mode 100644 security/tsem/Kconfig
 create mode 100644 security/tsem/Makefile
 create mode 100644 security/tsem/event.c
 create mode 100644 security/tsem/export.c
 create mode 100644 security/tsem/fs.c
 create mode 100644 security/tsem/map.c
 create mode 100644 security/tsem/model.c
 create mode 100644 security/tsem/namespace.c
 create mode 100644 security/tsem/trust.c
 create mode 100644 security/tsem/tsem.c
 create mode 100644 security/tsem/tsem.h

-- 
2.39.1

