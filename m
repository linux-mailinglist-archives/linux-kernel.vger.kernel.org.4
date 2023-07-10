Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E937274D439
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 13:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjGJLGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 07:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjGJLGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 07:06:00 -0400
Received: from blizzard.enjellic.com (wind.enjellic.com [76.10.64.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 41EF110C8;
        Mon, 10 Jul 2023 04:05:21 -0700 (PDT)
Received: from blizzard.enjellic.com (localhost [127.0.0.1])
        by blizzard.enjellic.com (8.15.2/8.15.2) with ESMTP id 36AANLIN019749;
        Mon, 10 Jul 2023 05:23:21 -0500
Received: (from greg@localhost)
        by blizzard.enjellic.com (8.15.2/8.15.2/Submit) id 36AANLvI019747;
        Mon, 10 Jul 2023 05:23:21 -0500
X-Authentication-Warning: blizzard.enjellic.com: greg set sender to greg@enjellic.com using -f
From:   "Dr. Greg" <greg@enjellic.com>
To:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net
Subject: [PATCH 02/13] Add TSEM specific documentation.
Date:   Mon, 10 Jul 2023 05:23:08 -0500
Message-Id: <20230710102319.19716-3-greg@enjellic.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230710102319.19716-1-greg@enjellic.com>
References: <20230710102319.19716-1-greg@enjellic.com>
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

An entry was added to the ABI testing documentation to document
the files in the TSEM management filesystem.

The file documenting the kernel command-line parameters was
updated to document the TSEM specific command-line parameters

The primary TSEM documentation file was added to the LSM
administration guide and the file was linked to the index of LSM
documentation.

Signed-off-by: Greg Wettstein <greg@enjellic.com>
---
 Documentation/ABI/testing/tsem                |  828 +++++++++
 Documentation/admin-guide/LSM/index.rst       |    1 +
 Documentation/admin-guide/LSM/tsem.rst        | 1526 +++++++++++++++++
 .../admin-guide/kernel-parameters.txt         |   18 +
 4 files changed, 2373 insertions(+)
 create mode 100644 Documentation/ABI/testing/tsem
 create mode 100644 Documentation/admin-guide/LSM/tsem.rst

diff --git a/Documentation/ABI/testing/tsem b/Documentation/ABI/testing/tsem
new file mode 100644
index 000000000000..cfb013b5f1f4
--- /dev/null
+++ b/Documentation/ABI/testing/tsem
@@ -0,0 +1,828 @@
+What:		/sys/kernel/security/tsem
+Date:		July 2023
+Contact:	Greg Wettstein <greg@enjellic.com>
+Description:
+		The /sys/kernel/security/tsem directory contains files
+		and directories that implement the control plane for
+		the Trusted Security Event Modeling (TSEM) LSM.
+
+		The files in this directory hierarchy, with the
+		exception of the aggregate file, when read, reflect
+		the values for the security modeling namespace that
+		the process reading the files is operating in.
+
+What:		/sys/kernel/security/tsem/id
+Date:		July 2023
+Contact:	Greg Wettstein <greg@enjellic.com>
+Description:
+		The id file contains the ASCII base 10 representation
+		of the model domain/namespace identifier that the
+		reading process is operating in.
+
+		The root security modeling namespace has a value of
+		zero, a non-zero value indicates a modeling namespace
+		subordinate to the root model.
+
+		Each externally modeled domain will have a file, with
+		this id number, created in the
+		/sys/kernel/security/tsem/ExternalTMA directory that
+		is documented below.
+
+What:		/sys/kernel/security/tsem/aggregate
+Date:		July 2023
+Contact:	Greg Wettstein <greg@enjellic.com>
+Description:
+		The aggregate file contains the ASCII base 16
+		representation of the 256 bit hardware platform
+		aggregate that TSEM is modeling under.  The platform
+		aggregate is the linear extension measurement of the
+		Trusted Platform Module PCR registers 0 through 8.
+
+		On a platform without a TPM this value will be all
+		null bytes.
+
+What:		/sys/kernel/security/tsem/control
+Date:		July 2023
+Contact:	Greg Wettstein <greg@enjellic.com>
+Description:
+		The control file is the only writable file in the
+		filesystem and is used by the trust orchestrator's to
+		configure and control the behavior of the TSEM
+		implementation.
+
+		The following keyword and arguments are recognized:
+
+		internal
+			The internal keyword causes an internally
+			modeled domain to be created for the calling
+			process.
+
+		external
+			The external keyword causes an externally
+			modeled domain to be created for the calling
+			process.
+
+			A modeling namespace created by these commands
+			accept the following set of key=value pairs
+			that configure the namespace:
+
+			nsref=initial|current
+				The nsref key specifies the namespace
+				that is to be referenced when
+				determining the UID/GID values that
+				define a COE or CELL identity.
+
+				The initial keyword specifies that the
+				initial user namespace be used.  The
+				current keyword specifies that the
+				user namespace of the process that is
+				invoking a security event handler
+				(hook) is used.
+
+			digest=digestname
+				The digest key is used to specify the
+				cryptographic hash function that is to
+				be used in the namespace for the
+				creation of COE and CELL identities.
+
+				The digestname is the name used by the
+				Linux kernel cryptographic API to
+				identify the hash function.  Examples
+				would include sha256, sha3-256, sm3
+				etc.  The source files for the
+				cryptographic hash function in the crypto
+				directory of the kernel source has the
+				names for hash functions implemented
+				in the kernel.
+
+				The sha256 hash function is the
+				default function for the root modeling
+				domain.  This can be modified by the
+				tsem_digest command-line parameter.
+
+				A hash function, used by the root
+				modeling domain, must be built into
+				the kernel.
+
+			cache=NN
+				The cache key specifies the size of
+				the caches to be used for holding
+				pointers to structures used for the
+				modeling or export of security events
+				that are called while the invoking
+				process is in atomic context.
+
+				The value NN is the ASCII base 10
+				representation of the number of
+				entries in the cache.
+
+				By default, the root modeling
+				namespace and an externally modeled
+				namespace will have 96 entries.  An
+				internally modeled namespace will have
+				16 entries.
+
+			key=HEXID
+				The key argument is used to specify
+				the authentication key that will be
+				used by a trust orchestrator to
+				authenticate trust control requests to
+				a process running in the security
+				modeling namespace.
+
+				The HEXID value is the ASCII base16
+				encoded key that is to be used.  The
+				length of this key, in binary, must be
+				equal to the size of the digest
+				produced by the cryptographic hash
+				function that is being used in the
+				modeling namespace.
+
+		enforce
+			The enforce keyword causes the modeling
+			domain/namespace of the process to enter
+			enforcing mode.  In this mode, a value of
+			-EPERM will be returned for a security event
+			coefficient that does not map into the current
+			set of allowed coefficients for the security
+			model being implemented in the namespace.
+
+		seal
+			The seal keyword causes the security model
+			being implemented for the namespace to be
+			placed in a sealed state.  In this state, the
+			current set of security coefficients is
+			considered to be the only set of valid
+			coefficients for the model.  Any subsequent
+			events that map to a coefficient not in the
+			current model will be considered a violation
+			of the model.
+
+		trusted pid=PID key=HEXID
+			The trusted keyword is used by a trust
+			orchestrator to indicate that the process
+			identified by the PID argument should be
+			allowed to run in trusted status after the
+			modeling of a security event.
+
+			The HEXID argument is the authentication key
+			that has been configured by a trust
+			orchestrator for the namespace at the time of
+			its creation.
+
+		untrusted pid=PID key=HEXID
+			The untrusted keyword is used by a trust
+			orchestrator to indicate that the process
+			identified by the PID argument should be
+			designated as an untrusted process.
+
+			The HEXID argument is the authentication key
+			that has been configured by a trust
+			orchestrator for the namespace at the time
+			its creation.
+
+		state value=HEXID
+			The state keyword is used to indicate that the
+			security state coefficient identified by the
+			ASCII base 16 encoded value specified by HEXID
+			should be loaded into the current security
+			model as a valid security event coefficient.
+
+		pseudonym valid=HEXID
+			The pseudonym keyword is used to indicate that
+			the pathname, identified by the ASCII base 16
+			encoded value HEXID, should be designated to
+			return a constant digest value for the
+			contents of the file named by the pseudonym.
+
+			The HEXID value is computed with the following
+			function:
+
+			HEXID = HF(PATHNAME_LENGTH || PATHNAME)
+
+			WHERE HF is the cryptographic hash function
+			that has been designated for use by the
+			security modeling namespace.
+
+		base value=HEXID
+			The base keyword is used to indicate that the
+			ASCII base 16 encoded value HEXID should be
+			registered as the value used to generate
+			security state coefficients for the model
+			implemented in the modeling namespace.
+
+			The binary length of the value specified by
+			HEXID must match the digest size of the
+			cryptographic hash function specified for use
+			in the security modeling namespace.
+
+			A model specific base value is designed to be
+			used as a 'freshness' nonce, similar to an
+			attestation nonce, to prove that a model state
+			value or measurement is current and not being
+			replayed.
+
+What:		/sys/kernel/security/tsem/InternalTMA
+Date:		July 2023
+Contact:	Greg Wettstein <greg@enjellic.com>
+Description:
+
+		This directory will contain directories that will be
+		used to hold files that surface model parameters for
+		Trusted Modeling Agents (TMA's) for internally modeled
+		security namespaces.
+
+		There is currently only one internal TMA that is
+		surfaced through the following directory:
+
+		/sys/kernel/security/tsem/InternalTMA/model0
+
+		The subsequent descriptions for the files implemented
+		in this directory will use ROOTDIR to represent the
+		above directory for space conservation purposes.
+
+What:		ROOTDIR/measurement
+Date:		July 2023
+Contact:	Greg Wettstein <greg@enjellic.com>
+Description:
+		The measurement file contains the ASCII base 16
+		representation of the time dependent linear extension
+		value of all the security state coefficients in the
+		model implemented by the namespace of the calling
+		process.
+
+What:		ROOTDIR/state
+Date:		July 2023
+Contact:	Greg Wettstein <greg@enjellic.com>
+Description:
+		The state file contains the ASCII base 16
+		representation of the functional value of a security
+		modeling namespace.
+
+		The state value is a time independent representation
+		of the measurement of a security model, and unlike the
+		measurement value, is a time independent
+		representation of the state.
+
+		This value is designed to be a single value that can
+		be attested to represent whether or not a workload has
+		deviated from a defined security behavior.
+
+What:		ROOTDIR/trajectory
+Date:		July 2023
+Contact:	Greg Wettstein <greg@enjellic.com>
+Description:
+		The trajectory file contains a description of the
+		security events that have occurred in a security
+		modeling namespace
+
+		Each entry in this file represents a single security
+		event and consists of a JSON encoded record with key
+		values that define the characteristics of the event.
+
+		Each line in a trajectory, or forensics, file will
+		always have the event and COE keys.  The event key
+		describes the characteristics of a security event
+		while the COE field describes the Context Of Execution
+		that is requesting execution of a security event.
+
+		The event key consists of the following
+		characteristic definitions:
+
+			process: COMM
+				Where COMM is the ASCII representation
+				of the name of the process executing
+				the event.
+
+			type: EVENT_TYPE
+				The value field for a type key is the
+				name of the security event that is
+				being modeled.  The list of EVENT_TYPE
+				names is defined in the following
+				source file:
+
+				security/tsem/tsem.c
+
+				If the security event is a generically
+				modeled event the EVENT_TYPE will be
+				generic_event.  In this case the CELL
+				characteristics for the event will be
+				described by a generic_event: key
+
+			task_id: HEXID
+				The value of the task_id key will the
+				ASCII base 16 representation of the
+				identity of the task that is executing
+				the security handler.  The length of
+				HEXID will match the size of the
+				digest value of the cryptographic hash
+				function selected for use by the
+				security modeling namespace.
+
+				The following documentation file:
+
+				Documentation/admin-guide/LSM/TSEM.rst
+
+				Describes how the TASK_ID value is
+				generated.
+
+		The COE key has the following characteristic keys.
+		Keys that involve discretionary access values
+		(uids/gids) will have their numeric value computed
+		based on the user namespace reference value that is
+		being implemented in the security modeling namespace.
+
+			uid: NN
+				The ASCII base 10 representation of
+				the numeric value of the discretionary
+				user id of the process that is
+				executing the security event.
+
+			euid: NN
+				The ASCII base 10 representation of
+				the numeric value of the effective
+				discretionary user id of the process
+				that is executing the security event.
+
+			euid: NN
+				The ASCII base 10 representation of
+				the numeric value of the effective
+				discretionary user id of the process
+				that is executing the security event.
+
+			suid: NN
+				The ASCII base 10 representation of
+				the numeric value of the saved user id
+				of the process that is executing the
+				security event.
+
+			gid: NN
+				The ASCII base 10 representation of
+				the numeric value of the discretionary
+				group id of the process that is
+				executing the security event.
+
+			egid: NN
+				The ASCII base 10 representation of
+				the numeric value of the discretionary
+				effective group id of the process that
+				is executing the security event.
+
+			egid: NN
+				The ASCII base 10 representation of
+				the numeric value of the discretionary
+				effective group id of the process that
+				is executing the security event.
+
+			sgid: NN
+				The base 10 ASCII representation of
+				the numeric value of the saved
+				discretionary group id of the process
+				that is executing the security event.
+
+			fsuid: NN
+				The base 10 ASCII representation of
+				the numeric value of the discretionary
+				filesystem user id of the process that
+				is executing the security event.
+
+			fsgid: NN
+				The ASCII base 10 representation of
+				the numeric value of the discretionary
+				filesystem group id of the process
+				that is executing the security event.
+
+			capeff: 0xNNN
+				The ASCII base 16 representation of
+				the numeric value of effective
+				capabilities of the process that is
+				executing the security event.
+
+		If the CELL value for a security event includes the
+		definition of a file a file: key value will be
+		included.  The following characteristics will be
+		encoded in this field:
+
+			flags: NN
+				The ASCII base 10 representation of
+				the flags value of the 'struct file'
+				structure that is the source of the
+				file description.
+
+			uid: NN
+				The ASCII base 10 representation of
+				the discretionary user id of the file.
+
+			gid: NN
+				The base 10 ASCII representation of
+				the discretionary group id of the
+				file.
+
+			mode: 0NNN
+				The ASCII base 8 representation of the
+				mode bits of the file.
+
+			name_length: NN
+				The ASCII base 10 representation of
+				the length of the pathname that will
+				be encoded in the name= characteristic.
+
+			name: NN
+				The ASCII hexadecimal representation
+				of the SHA256 checksum of the pathname
+				of the file that is pre-pended with
+				the little-endian binary value of the
+				length of the pathname.
+
+			s_magic: 0xNN
+				The ASCII base 16 representation of the
+				magic number of the filesystem that
+				contains the file.
+
+			s_id: NAME
+				The ASCII name of the block device for
+				the filesystem that contains the file.
+
+			s_UUID: HEX
+				The ASCII base 16 representation of
+				the hexadecimal value of the UUID of
+				the filesystem that contains the file.
+
+			digest: HEX
+				The ASCII base 16 representation of
+				the SHA256 digest of the file.
+
+		If the event type is the memory mapping of a file a
+		mmap_file key value will be included with
+		the following characteristics:
+
+			type: N
+				Where N is an ASCII 0 or 1 to indicate
+				whether or not the mapping is file
+				backed or anonymous.  A value of 1 is
+				used to indicate an anonymous mapping.
+
+			reqprot: NN
+				Where N is ASCII base 10
+				representation of the protections
+				requested for the mapping.
+
+			prot: NN
+				Where N is the ASCII base 10
+				representation of the protections that
+				will be applied to the mapping.
+
+			flags: NN
+				Where N is the ASCII base 10
+				representation of the flags that will
+				be used for the memory mapping operation.
+
+		If the event type is a socket creation event a
+		socket_create key value will be included with the
+		following characteristics:
+
+			family: N
+				Where N is the ASCII base 10
+				representation of the family type of
+				the socket.
+
+			type: N
+				Where N is the ASCII base 10
+				representation of the type of socket
+				being created.
+
+			protocol: N
+				Where N is the ASCII base 10
+				representation of the protocol family
+				for the socket.
+
+			kern: 0 | 1
+				Where 0 or 1 is used to indicate
+				whether or not the socket is kernel
+				based.  A value of 1 implies it is
+				kernel based.
+
+		If the event type is a socket_connect or a
+		socket_bind, a socket_connect: or a socket_bind: key
+		value will be included that will be characterized
+		based on an encoding of either an IPV4, IPV6, AF_UNIX
+		or a generic socket description.
+
+			family: N
+				Where N is the ASCII base 10
+				representation of the family type of
+				the socket.
+
+			port: N
+				Where N is the base ASCII base 10
+				representation of the port number that
+				is being used for either an IPV4 or
+				IPV6 socket connection or bind.
+
+			addr: N | PATH | HEXID
+				In the case of an IPV4 socket the
+				value for the addr key will be the
+				ASCII base 10 representation of the 32
+				bit IPV4 address being bound or
+				connected to.
+
+				In the case of an IPV6 connection the
+				value to the key will be the ASCII
+				base 16 representation of the 128 bit
+				address being bound connected.
+
+				In the case of an AF_UNIX connection
+				the value will be the pathname of the
+				socket in the mount namespace that the
+				process is running in.
+
+				In the case of any other type of
+				socket the addr value will be the
+				ASCII base 16 representation of the
+				cryptographic digest value of the
+				entire length of the address
+				description.  The length of the
+				representation will be the size of the
+				digest produced by the cryptographic
+				hash function that has been specified
+				for the modeling namespace.
+
+			flow: N
+				For an IPV6 socket the value of the
+				flow key will be the ASCII base 10
+				representation of the flow identifier
+				assigned to the socket.
+
+			scope: N
+				For an IPV6 socket the value of the
+				scope key will be the ASCII base 10
+				representation of the scope identifier
+				assigned to the socket.
+
+		If the event type is a socket_accept a socket_accept
+		key value will be included that characterizes either
+		an IPV4, IPV6 or a generic socket description with the
+		following event descriptions:
+
+			family: N
+				Where N is the ASCII base 10
+				representation of the family type of
+				the socket.
+
+			type: N
+				Where N is the ASCII base 10
+				representation of the type of the
+				socket being created.
+
+			port: N
+				Where N is the base ASCII base 10
+				representation of the port number that
+				is being used for either an IPV4 or
+				IPV6 socket connection or bind.
+
+			addr: N | PATH | HEXID
+				In the case of an IPV4 socket the
+				value for the addr key will be the
+				ASCII base 10 representation of the 32
+				bit IPV4 address being bound or
+				connected to.
+
+				In the case of an IPV6 connection the
+				value to the key will be the ASCII
+				base 16 representation of the 128 bit
+				address being bound connected.
+
+				In the case of an AF_UNIX connection
+				the value will be the pathname of the
+				socket in the mount namespace that the
+				process is running in.
+
+				In the case of any other type of
+				socket the addr value will be the
+				ASCII base 16 representation of the
+				cryptographic digest value of the
+				entire length of the address
+				description.  The length of the
+				representation will be the size of the
+				digest produced by the cryptographic
+				hash function that has been specified
+				for the modeling namespace.
+
+What:		ROOTDIR/trajectory_coefficients
+Date:		July 2023
+Contact:	Greg Wettstein <greg@enjellic.com>
+Description:
+		The trajectory_coefficients file will output the ASCII
+		base16 representation of each security state
+		coefficient that has been generated by the security
+		modeling namespace of the calling process.
+
+		The length of each point will be the ASCII
+		representation of the size of the cryptographic hash
+		function that has been specified for the model.
+
+What:		ROOTDIR/trajectory_counts
+Date:		July 2023
+Contact:	Greg Wettstein <greg@enjellic.com>
+Description:
+		The trajectory_coefficients file will output the ASCII
+		base10 representation of the number of times each
+		security state coefficient has been generated by the
+		security modeling namespace of the calling process.
+
+What:		ROOTDIR/forensics
+Date:		July 2023
+Contact:	Greg Wettstein <greg@enjellic.com>
+Description:
+		The forensics file contains the descriptions of
+		security events that are inconsistent with the
+		security model that the security namespace is
+		implementing.  Forensics events are generated after a
+		security model is 'sealed' and the events represent
+		security state coefficients that have not already been
+		generated by the model.
+
+		The format of lines in this file are identical to the
+		output generated by the ROOTDIR/trajectory file
+		that is documented above.
+
+What:		ROOTDIR/forensics_coefficients
+Date:		July 2023
+Contact:	Greg Wettstein <greg@enjellic.com>
+Description:
+		The forensics_coefficients file will output the ASCII
+		base16 representation of each security state
+		coefficient that have been generated by forensics
+		events in the security modeling namespace of the
+		calling process.
+
+		The length of each point will be the ASCII
+		representation of the size of the cryptographic hash
+		function that has been specified for the model.
+
+What:		ROOTDIR/forensics_counts
+Date:		July 2023
+Contact:	Greg Wettstein <greg@enjellic.com>
+Description:
+		The forensics_counts file will output the ASCII base10
+		representation of the number of times each security
+		state coefficient, generated by a forensics event, has
+		been generated by the security modeling namespace of
+		the calling process.
+
+What:		/sys/kernel/security/tsem/ExternalTMA
+Date:		July 2023
+Contact:	Greg Wettstein <greg@enjellic.com>
+Description:
+		The ExternalTMA directory is a container directory
+		that hold files that will be used to export the
+		security events, and their associated parameters, for
+		externally modeled security modeling namespaces.
+
+		The files created in this directory will be named by
+		the base 10 ASCII representation of the id value
+		assigned to the security modeling namespace.  See the
+		documentation for the /sys/kernel/security/tsem/id
+		file in this documentation for more details on this
+		value.
+
+		This file will is a read-only file that can be polled
+		by a userspace trust orchestrator implementation to
+		process security events that are to be modeled by an
+		external Trusted Modeling Agent.
+
+		Each exported event is a JSON encoded record
+		describing the event that is to be processed.
+
+		Each record will have an 'export' key that has a
+		structure associated with it that has a 'type' key in
+		it.  The 'type' key has a string value associated with
+		it that defines the type of event that is being
+		processed.
+
+		The following export 'type' strings are defined:
+
+		aggregate:
+			The aggregate key has an associated structure
+			value that defines a key named 'value' that
+			has a string value associated with it that
+			represents the hardware aggregate for the
+			platform.
+
+			The hardware aggregate string is expressed as
+			the ASCII base16 representation of the
+			platform hardware aggregate value.  The length
+			of the string will be the size of the digest
+			produced by the cryptographic hash function
+			that has been specified for the security
+			modeling namespace of the process generating
+			the event.
+
+		async_event:
+			If the type of the export is async_event there
+			will be a key named 'event' that has a structure
+			value associated with it.
+
+			The structure associated with the 'event' key
+			will be identical to the structure generated
+			for the 'event' key that is described below.
+
+		event:
+			If the type of the export is event there will
+			be a key named 'event' that has a structure
+			value associated with it that contains the
+			follow key: value pairs.
+
+			pid: NNN
+				Where the NNN is the ASCII base 10
+				value of the id of the process that is
+				executing the security event that will
+				be modeled.
+
+			process: COMM
+				Where COMM is the ASCII representation
+				of the name of the process executing
+				the event.
+
+			type: EVENT_TYPE
+				The value field for a type key is the
+				name of the security event that is
+				being modeled.  The list of EVENT_TYPE
+				names is defined in the following
+				source file:
+
+				security/tsem/tsem.c
+
+				If the security event is a generically
+				modeled event the EVENT_TYPE will be
+				generic_event.  In this case the CELL
+				characteristics for the event will be
+				described by a generic_event: key
+
+			task_id: HEXID
+				The value of the task_id key will the
+				ASCII base 16 representation of the
+				identity of the task that is executing
+				the security handler.  The length of
+				HEXID will match the size of the
+				digest value of the cryptographic hash
+				function selected for use by the
+				security modeling namespace.
+
+				The following documentation file:
+
+				Documentation/admin-guide/LSM/TSEM.rst
+
+				Describes how the TASK_ID value is
+				generated.
+
+			There will be a COE key that references a
+			value structure that has the same format as
+			the COE key that is emitted for a trajectory
+			or forensics event.
+
+			The record will have a key value that is
+			identical to the value associated with the
+			'type' key documented above.  The 'type' key
+			will have a structure value that contains a
+			definition of the event.  The definitions for
+			the event will be identical to the description
+			of the event that is emitted for a trajectory
+			or forensics event in the internal TMA
+			implementation.
+
+		log:
+			An export type of log is emitted when an
+			untrusted task attempts to execute a security
+			event.
+
+			There will be a 'log' key in the record that
+			references a structure containing the
+			following key values:
+
+			process: COMM
+				The process key has a string value
+				associated with it that will contain
+				the COMM name of the untrusted process
+				that invoked processing of the
+				security event.
+
+			event: NAME
+				The event key has a string value
+				associated with that will contain the
+				name of the security event hook that
+				was called by an untrusted process.
+
+				The names for the security events are
+				defined in the following source file:
+
+				security/tsem/tsem.c
+
+			action: TYPE
+				The action key has a string value that
+				describes the action take by the TSEM
+				security hook in response to being
+				called by an untrusted process.
+
+				This string value will be either LOG
+				or DENY.
diff --git a/Documentation/admin-guide/LSM/index.rst b/Documentation/admin-guide/LSM/index.rst
index a6ba95fbaa9f..cebd3b02598d 100644
--- a/Documentation/admin-guide/LSM/index.rst
+++ b/Documentation/admin-guide/LSM/index.rst
@@ -47,3 +47,4 @@ subdirectories.
    tomoyo
    Yama
    SafeSetID
+   tsem
diff --git a/Documentation/admin-guide/LSM/tsem.rst b/Documentation/admin-guide/LSM/tsem.rst
new file mode 100644
index 000000000000..3810dd3b6e6d
--- /dev/null
+++ b/Documentation/admin-guide/LSM/tsem.rst
@@ -0,0 +1,1526 @@
+====
+TSEM
+====
+
+	"This is the story of the wine of Brule, and it shows what
+	 men love is never money itself but their own way, and
+	 that human beings love sympathy and pageant above all
+	 things."
+				- Hilaire Belloc
+				  The Path to Rome
+
+TSEM is the Trusted Security Event Modeling system.  TSEM is the
+kernel infrastructure that provides a platform for implementing
+security policies based on either deterministic or machine learning
+models.  It also provides a framework for implementing Host Based
+Intrusion Detection (HIDS) and anomaly detection without the need to
+write kernel code or implement kernel loadable modules
+
+The design and implementation of TSEM is inspired by the notion that
+the security behavior of a platform, or a workload, like all other
+physical phenomenon, can be mathematically modeled.
+
+Security, is at once, both a technical and economic problem.  One of
+the objectives of TSEM is to address inherent and structural economic
+barriers to security, by introducing technology that reduces the skill
+and time needed to implement a level of security, equivalent to what
+can be achieved by mandatory access controls, through unit testing of
+an application stack.
+
+A second objective is to reduce the skill, complexity and
+infrastructure needed to create trusted and remotely attestable
+platforms and/or workloads.
+
+To achieve these objectives, TSEM implements the concept of a security
+modeling namespace that reduces the complexity of a security model and
+allows it to be scoped to the level of a single process hierarchy or a
+container.
+
+TSEM is the Linux kernel component of a security concept introduced by
+the Quixote Project, the notion of a Trust Orchestration System (TOS).
+The concept of a TOS is to have a system with a minimal Trusted
+Computing Base (TCB) that supervises and maintains subordinate
+security modeling namespaces in a known state of trust.
+
+TSEM is implemented as a Linux Security Module (LSM) and is designed
+to be self-contained with little or no dependency on kernel
+infrastructure, other than the LSM hooks themselves.  It can be
+stacked in any order with existing LSM's.  It is implemented as the
+first LSM in the call sequence since it provides infrastructure that
+can be used, for example, to validate extended attributes that may be
+used by subsequently invoked LSM's.
+
+TSEM implements its equivalent of mandatory access controls, without a
+requirement for extended attributes, filesystem labeling or the need
+to protect filesystem metadata against offline attack.  A mathematical
+defined security model, generated by unit testing of a workload, is the
+entity that carries the security guarantee for system or workload.
+
+TBDHTTRAD
+=========
+
+A quick summary for those interested in experimenting with trust
+orchestration and security modeling but are constrained by: 'Too Busy
+Don't Have Time To Read Any Documentation'.
+
+A kernel with TSEM support in its list of enabled LSM's must be
+available for use.  A TSEM enabled kernel will have the tsem keyword
+in the following file:
+
+/sys/kernel/security/lsm
+
+For experimentation, or integrating TSEM modeling into a Continuous
+Integration/Continous Development (CI/CD) workflow, modeling
+can be restricted to subordinate security namespaces by booting a kernel
+with the following kernel command-line option:
+
+tsem_mode=1
+
+This disables modeling of the root security namespace and only
+implements modeling for subordinate namespaces.
+
+The Quixote trust orchestration utilities either need to be built or
+the statically compiled sample utilities need to be installed.  Source
+for the userspace utilities and compiled sample programs are available
+at the following location:
+
+ftp://ftp.enjellic.com/pub/Quixote
+
+After installing the utilities, two shell sessions will be needed with
+root privileges in each shell.
+
+The following directories need to be in the PATH variable of each shell:
+
+/opt/Quixote/sbin
+/opt/Quixote/bin
+
+Execute the following command to start a process in an independent
+security namespace with the modeling being done in the kernel:
+
+quixote -P -c test -o test.model
+
+In the second shell session, run the following command to display the
+security execution trajectory of the model:
+
+quixote-console -p test -T
+
+In the shell session provided by the trust orchestrator, run the
+following command:
+
+grep SOME_STRING /etc/passwd
+
+Then exit the shell.
+
+The orchestrator will indicate that the security model definition has
+been written to the test.model file.
+
+Run the following command to execute a shell in an enforced security
+model obtained from the previous session:
+
+quixote -P -c test -m test.model -e
+
+In the shell that is provided, run the following command:
+
+cat /etc/passwd
+
+The command will fail.
+
+Running the following command in the second shell session will output
+forensics on the command that failed:
+
+quixote-console -p test -F
+
+Executing additional commands in the trust orchestrated shell will
+cause additional entries to be added to the forensics trajectory.
+
+The test can be repeated using the quixote-us trust orchestrator.
+This test will model the security namespace in a userspace process
+rather than in the kernel based trusted modeling agent.
+
+Mandatory Access Controls
+=========================
+
+	"If I have seen further it is by standing on the shoulders of
+	 Giants."
+				- Sir Isaac Newton
+
+It is assumed that astute readers will be familiar with classic
+subject/object based mandatory access controls; or at least astute
+enough to use a search engine to develop a modicum of secundem artem
+in the discipline.
+
+Very simplistically, subject/object based mandatory access controls
+can be thought of as being implemented with a two dimensional access
+vector matrix, with some type of a description of a process (subject)
+on one axis and a description of a data sync/source (object),
+typically an inode, on the second axis.  The descriptions are
+commonly referred to as subjects and objects.
+
+A security policy is developed that assigns a boolean value for each
+element of the matrix that specifies whether or not permission should
+be granted for the subject to access the object.
+
+These schemes are frequently referred to as 'mandatory access
+controls', since only the kernel has the ability to implement the
+labeling and decision processes.  In these systems, the root or
+administrative user has no ability to affect kernel decision making
+with respect to whether or not permission is granted or denied.
+
+These systems were derived from governmental and military information
+classification systems and are capable of delivering security
+guarantees appropriate to classified and high sensitivity assets.  The
+delivery of these security guarantees comes with it a reputation for
+complexity and fragility.
+
+Development of a system wide security policy is a complex process and
+administration of such systems is frequently done in an iterative
+fashion.  The system is monitored for permission denials with
+modifications to correct these false denials folded back into the
+policy.  In many cases, mandatory access control systems are run in
+warning rather than enforcing mode and used as an indicator for
+potential security violations.
+
+One of the additional challenges is that the integrity of labels is
+fundamental to the ability of these systems to deliver their security
+guarantees.  This requires that the labeling process be conducted
+under security controlled conditions, with the labels subsequently
+protected against offline modification by cryptographic integrity
+guarantees.
+
+Mandatory access controls had their origin in centralized multi-user
+platforms, and before the now widely accepted, strategy of using
+resource compartmentalization (namespaces) to isolate applications
+from each other and the system at large.  A legitimate technical
+argument can be made as to whether or not enforcement of a system wide
+security policy is suitable for these environments.
+
+At the other end of the spectrum, in embedded systems, structural
+economic barriers incent very little attention to security, where time
+to market is the primary goal.  These systems are pushed into the
+field, many time for multi-year operational lifetimes, with little
+prospect for upgrades or any notion of an iterative tuning process of
+a security policy.
+
+Security Event Modeling
+=======================
+
+	"We can no longer speak of the behavior of the particle
+	 independently of the process of observation. As a final
+	 consequence, the natural laws formulated mathematically in
+	 quantum theory no longer deal with the elementary particles
+	 themselves but with our knowledge of them. Nor is it any
+	 longer possible to ask whether or not these particles exist in
+	 space and time objectively ... When we speak of the picture of
+	 nature in the exact science of our age, we do not mean a
+	 picture of nature so much as a picture of our relationships
+	 with nature.  ...Science no longer confronts nature as an
+	 objective observer, but sees itself as an actor in this
+	 interplay between man and nature. The scientific method of
+	 analysing, explaining and classifying has become conscious of
+	 its limitations, which arise out of the fact that by its
+	 intervention science alters and refashions the object of
+	 investigation. In other words, method and object can no longer
+	 be separated."
+				- Werner Karl Heisenberg
+
+Security Event Modeling (SEM), is an alternative strategy to implement
+the security guarantees of mandatory access and integrity controls, in
+a manner that is consistent with emerging application development
+strategies such as namespaces and CI/CD workflows.
+
+As was noted at the start of this document, the premise for SEM is
+that the security behavior of a platform, or alternatively a workload,
+can be modeled like any other physical phenomenon in science and
+engineering.
+
+Inspiration for this came from the primary TSEM author/architect
+having trained as a quantum chemist, conducting very early research in
+the development of multi-scale modeling strategies for molecules of
+size to be of interest to pharmaceutical intents.
+
+SEM is premised on the theory that kernel security architects have
+instrumented the LSM security event hooks to be called from all
+locations, with appropriate descriptive parameters, that are relevant
+to the security posture of the kernel.  With respect to modeling, the
+security event hooks are conceptualized as representing the
+independent variables of a basis set that yields a functional
+definition for the security state of an execution trajectory.
+
+SEM can be framed in the context of classic subject/object mandatory
+access controls, by the notion that a unique identity can be generated
+for each element of an access vector matrix, rather than a boolean
+value.  In SEM, a security execution trajectory is defined by the set
+of security state coefficients that a process hierarchy (workload)
+generates.  This execution trajectory produces a vector of identities,
+whose sum in an appropriate form, yields a functional definition of
+the security state of the system.
+
+Two subordinate identities are combined to yield a security event
+state coefficient.  These subordinate identities are referred to as the
+Context Of Execution (COE) and the CELL, which are conceptually
+similar to the subject and object in mandatory access control.  The
+COE identity is derived from the parameters that describe the security
+relevant characteristics of a process, while the CELL value is derived
+from the parameters used by a security event hook to describe the
+characteristics of the event.
+
+A security policy is implemented by a modeling algorithm that
+translates COE and CELL event parameters into their respective
+identities.  The COE and CELL are combined to yield a security state
+coefficient that uniquely describes the security event in the security
+model.  Different security policies and criteria can be developed by
+modifying how the modeling algorithm utilizes the COE and CELL
+characteristics.
+
+Since the security policy is implemented with a modeling algorithm, a
+single platform can support multiple and arbitrary security policies.
+The equivalent of a resource namespace in SEM is referred to as a
+security modeling namespace.
+
+The formation of the security state coefficients from existing kernel
+parameters eliminates the need for the use of extended attributes to
+hold security label definitions.  In SEM, a cryptographically signed
+security model definition, designed to be interpreted by a modeling
+algorithm, becomes the bearer's token for the security of the modeled
+workload, rather than information encoded in filesystem security
+attributes.
+
+Trusted Security Event Modeling
+===============================
+
+	"Do you see over yonder, friend Sancho, thirty or forty
+	 hulking giants?  I intend to do battle with them and slay
+	 them."
+				- Don Quixote
+
+In TSEM, the modeling algorithm is implemented in an entity known as a
+Trusted Modeling Agent (TMA), in a 'trusted' environment where
+modeling is immune from modification or alteration by any activity on
+the platform or in a workload.  The notion of a TMA provides a
+framework for next generation security co-processors that extend
+functionality beyond what is defined by the concept of a Trusted
+Platform Module (TPM).
+
+In addition to providing an attestation of an execution trajectory, a
+TMA, in contrast to a TPM, has the ability to advise an operating
+system on whether or not an event being modeled is consistent with the
+security model that is being enforced.  In this manner, it introduces
+a prospective rather than a retrospective trust model.
+
+TSEM is designed to support Trust Orchestration Systems (TOS).  In a
+TOS, the trust orchestrators are supervisory programs that run
+workloads in independent modeling namespaces , enforcing a workload
+specific security model.  Each trust orchestrator is paired with a
+'trusted partner TMA', known as a Sancho, that implements the workload
+specific modeling algorithm.
+
+The root of trust for a workload modeling namespace is based on where
+the TMA instance is implemented.  As an example, the Quixote TOS
+implementation currently offers orchestrators for the following TMA
+execution localities:
+
+- Kernel.
+
+- Userspace process.
+
+- SGX enclave.
+
+- Xen stub domain.
+
+- Micro-controller.
+
+This partitioning of trust results in the concept of security modeling
+namespaces being referred to as internally or externally modeled.  A
+TMA implementation run in the kernel is referred to as an internally
+modeled namespace; TMA's run outside of the kernel are referred to as
+an externally modeled namespace.
+
+The TMA, regardless of locality, is responsible for processing the
+characteristics that describe a security event, computing the identity
+for the COE and CELL and then combining these two identities to create
+a security state coefficient.  With respect to modeling theory, the
+coefficient is a task specific value representing the event in a
+security model.
+
+TSEM is dispassionate with respect to the type of algorithm that is
+implemented.  The processing of the security event characteristics and
+their conversion to security coefficients, is driven by the security
+model/policy that will be implemented for the workload.  The
+architecture is designed to support security modeling algorithms that
+are either deterministic or embrace approximations, stochastic
+inference and machine learning algorithms in response to specific
+workload, platform or device requirements.
+
+A security model, to be enforced by a trust orchestrator, is
+implemented by providing the TMA with a set of security state
+coefficients that are to be observed.  A TMA processes the
+characteristics of a security event and converts the characteristics
+to a security state coefficient that is evaluated against the
+coefficients provided to the TMA as the reference security model for a
+workload.
+
+A security event that translates to one of the provided 'good'
+coefficients, will cause the TMA to indicate to the trust orchestrator
+that the process is to be allowed to run as a trusted process.  A
+security event that does not map to a known good coefficient, results
+in the trust orchestrator designating that the process be labeled as
+an untrusted process.
+
+Trust orchestrators and their associated TMA's, are designed to
+support signed security models.  This results in the elimination of
+the requirement to verify or appraise extended attributes and other
+measures currently required to protect labeled security systems
+against offline attacks.
+
+The use of a cryptographic hash function to generate the security
+coefficient results in the definition of very specific security
+behaviors, that are sensitive to any variation in their
+characteristics.  Any offline modifications to files will result in a
+coefficient that is inconsistent with a signed model provided to a
+TMA.
+
+In order to support the development of TSEM based security models, a
+TMA is designed to run in one of three separate modes, referred to as
+follows:
+
+- Free modeling.
+
+- Sealed.
+
+- Enforcing.
+
+In a free modeling configuration, the TMA adds the security state
+coefficient for the characteristics of a security event to the current
+set of known good states.  In addition, the description of the
+security event is retained as a member of the security execution
+trajectory for the model.  This mode is used, in combination with unit
+testing of a workload, to generate a security model for subsequent
+enforcement.
+
+Placing a TMA in 'sealed' mode implies that any subsequent security
+coefficients, that do not map into a known security state, are to be
+considered 'forensic' violations to the security state of the model.
+
+This mode is designed to provide the ability to either fine tune a
+model or provide early warning of a potential attempt to subvert the
+security status of a workload.  The characteristics of the violating
+event are registered in the forensics trajectory of the model for use
+in subsequent evaluation of the violating event and/or model
+refinement.
+
+Placing a TMA model in 'enforcing' status implies that the model is in
+a sealed state and any subsequent violations to the model will result
+in the violating process being placed in untrusted status and a
+permissions violation returned to the task invoking the security
+event.
+
+Process and Platform Trust Status
+=================================
+
+A fundamental concept in TSEM is the notion of providing a precise
+definition for what it means for a platform or workload to be trusted.
+A trusted platform or workload is one where there has not been an
+attempt by a process to execute a security relevant event that does
+not map into a known security state coefficient.
+
+The process trust status is a characteristic of the process that is
+passed to any subordinate processes that are descendants of that
+process.  Once a process is tagged as untrusted, that characteristic
+cannot be removed from the process.  In a 'fruit from the poisoned
+vine' paradigm, all subordinate processes created by an untrusted
+process are untrusted as well.
+
+On entry into each TSEM security event handler, the trust status of a
+process is checked before an attempt to model the event is made.  An
+attempt to execute a security event by an untrusted process will cause
+the event, and its characteristics, to be logged.  The return status
+of the hook will be determined by the enforcement state of the model.
+A permission denial is only returned if the TMA is running in
+enforcing mode.
+
+If the platform running the TSEM LSM has a TPM, the hardware aggregate
+value is computed at the time that TSEM is initialized.  This hardware
+aggregate value is the linear extension sum over Platform
+Configuration Registers (PCR's) 0 through 7.  This is the same
+aggregate value that is computed by the Integrity Measurement
+Architecture (IMA) and is the industry standard method of providing an
+evaluation measurement of the hardware platform state.
+
+Internally modeled namespaces have the hardware aggregate measurement
+included as the first event in the security model.  Externally modeled
+namespaces export the hardware aggregate value to the TMA for
+inclusion as the first event of the model maintained by the external
+TMA.
+
+The root security model extends each security state coefficient into a
+PCR.  The default PCR is 11 but is configurable through the kernel
+configuration process.  The use of a separate PCR from IMA allows
+hardware based TSEM measurements to coexist with IMA measurement
+values.  This hardware measurement value is designed to allow
+attestation to the hardware state that the root model is running in.
+
+TSEM is designed to support a philosophy where the root security
+namespace will be a minimum Trusted Computing Base implementation that
+will only be running trust orchestrators.  Subordinate modeling
+namespaces are non-hierarchical so as to decrease model complexity in
+the subordinate namespaces in order to support a single functional
+value describing the security status of a modeling namespace.
+
+The Linux TSEM Implementation
+=============================
+
+	"Sometimes the questions are complicated and the answers are
+	 simple."
+				- Dr. Seuss
+
+The Linux TSEM implementation is deliberately simplistic and consists
+of the following two generic components:
+
+- Modeling namespace and security event export functionality.
+
+- Internal trusted modeling agent.
+
+The modeling namespace and export functionality is designed to be
+generic infrastructure that allows security namespaces to be created that
+are either internally or externally modeled.  The TSEM implementation
+does not pose any constraints on what type of modeling can or should
+be implemented in these namespaces.
+
+On the theory that security event handlers represent all of the
+security relevant action points in the kernel, any security or
+integrity model can be implemented using the TSEM infrastructure.  For
+example, basic IMA functionality could be implemented by a TMA that
+maps the digests of files accessed, or mapped executable, by the root
+user as the security state coefficients.
+
+A primary intent of the Linux TSEM implementation is to provide a
+generic method for implementing security policy in userspace rather
+than the kernel.  This is consistent with what has been the historic
+understanding in Linux architecture, that policy decisions should be
+delegated, when possible, to userspace rather than to kernel based
+implementations.
+
+The model is extremely simplistic; a TMA interprets a security event
+and its characteristics and advises whether or not the kernel should
+designate the process as trusted or untrusted after event processing
+is complete.
+
+The following sections discuss various aspects of the infrastructure
+used to implement this architecture.
+
+Internal vs external modeling
+-----------------------------
+
+When a TSEM modeling namespace is created, a designation is made as to
+whether the namespace is to be internally or externally modeled.
+
+In an internally modeled namespace, the security event handlers pass the
+event type and its characteristics to the designated internal trusted
+modeling agent.  The agent provides the permission value for the
+security event handler to return as the result of the event and sets
+the trust status of the process executing the event.
+
+In an externally modeled namespace, the event type and parameters are
+exported to userspace for processing by a trust orchestrator with an
+associated TMA.  The trust orchestrator communicates the result of the
+modeling back to the kernel to support the setting of the process
+trust status.
+
+The exception to this model are for security event handlers that are
+called in atomic, ie. non-sleeping context.  The export of these
+security event descriptions are done asynchronously in order to avoid
+having the TSEM implementation attempt to sleep in atomic context
+while the userspace trust orchestrator is scheduled for execution.
+
+It is up to the trust orchestrator and its security policy to
+determine how it handles events that violate the security model being
+enforced.  The Quixote trust orchestrators shut down the entire
+workload running in the security namespace if an asynchronously
+modeled event violates the security model being enforced and the model
+is running in enforcing mode.
+
+Internally modeled domains are able to provide immediate interception
+and modification of the trust status of a process that is violating
+the security model.  This has implications for the root security
+namespace that is running on a system with a TPM, since the security
+event coefficients are logged to the Platform Configuration Register
+that is being used by TSEM.
+
+Issuing the TPM transaction would cause the process to attempt to
+sleep while it waits for the TPM transaction to complete.  In order to
+address this issue the TPM transactions are deferred to an ordered
+workqueue for execution.  The use of an ordered workqueue maintains
+the time dependency of the security coefficients being registered.
+
+In order to handle modeling of security events in atomic context the
+TSEM implementation maintains caches (magazines) of structures that
+are needed to implement the modeling and export of events.  The size
+of this cache can be configured independently for each individual
+security modeling namespace that is created.  The default
+implementation is for a cache size of 16 for internally modeled
+namespaces and 96 for externally modeled namespaces.
+
+By default the root security namespace uses a cache size of 96.  This
+value can be configured by the 'tsem_cache' kernel command-line
+parameter to an alternate value.
+
+Trust Orchestrator/Process authentication
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The process identifier values (PID's) that are exported in the
+security event descriptions are the unique global PID values, not the
+value as seen through the lens of a PID namespace.
+
+PID values are, by default, not considered to be a stable identifier
+between the kernel and userspace.  In the case of TSEM external
+modeling, the threat model for a namespace is whether or not an
+adversarial process, running in either the root modeling namespace or
+another subordinate modeling namespace, can kill a process that is
+being orchestrated and substitute an alternate process with an
+identical PID value.
+
+The trust orchestrator would then be deluded into setting the trust
+status of the adversarial process rather than the one that had emitted
+the security event characteristics.  The threat interval is the
+latency time required for the processing of the security event
+description by the trust orchestrator and its associated TMA.
+
+Exploiting this theoretical race is extremely complex and requires an
+in depth understanding of the TSEM architecture.  Rather than discuss
+the conditions that must be met and their implications, this
+discussion will focus on the generic threat model and the mechanisms
+that TSEM implements in order to mitigate this threat.
+
+In short, a process in an adversarial security modeling namespace would
+want to execute security events that are barred from its security
+model with the hope of having them approved by an alternate namespace.
+
+In order to exploit the race, an adversarial process would have to
+force the termination of a process in the target namespace and then
+fork and exit a process a sufficient number of times in order to have
+a process under its control match the PID value of the process that
+was waiting for an orchestration response.
+
+Measured modeling latency times for a trust orchestrator running the
+deterministic Quixote TMA in userspace, on current generation 3.x
+x86_64 hardware, averages 170 micro-seconds.  In a worst case
+scenario from the perspective of an adversary, there would be a need
+to force the termination of the target process and then fork and
+execute a sufficient number of times to force the PID collision
+during this time interval.
+
+As a generic protection, TSEM in the tsem_task_kill() handler, blocks
+the notion of 'cross-model' signals, ie. a signal originating from an
+external modeling namespace.  This would require the adversary to
+reliably force a process termination through a mechanism other than
+signaling, for example, through the OOM killer whose signal
+transmission would not be blocked by this policy control.
+
+When a subordinate security modeling namespace is created, the id
+number of the namespace is registered in the tsem_task structure of
+the trust orchestrator that is creating the namespace.  The TSEM
+driver will refuse to honor control plane requests affecting the trust
+status of a process whose trust orchestrator security namespace id
+does not match the id of the process that it is being asked to act on.
+
+As an additional protection, TSEM uses an authentication strategy that
+allows a process running in a security modeling namespace to verify
+that a control request is coming from the trust orchestrator that
+initiated the namespace the process is running in.  As part of the
+setup of a security modeling namespace, a trust orchestrator is
+required to provide a hexadecimally encoded authentication key that
+matches the length of the cryptographic hash function being used to
+generate security state coefficient in the modeling namespace.  This
+authentication key must be provided by the trust orchestrator for
+every subsequent control plane request.
+
+The process that is being transferred to a subordinate security
+modeling namespace generates a second random key that is hashed with
+the authentication key provided by the trust orchestrator, using the
+hash function that has been defined for the security namespace.  The
+resultant digest value is compared to a list of authentication keys
+for all currently executing namespaces.  The selection of the second
+random key is repeated until a globally unique key is generated.
+
+This randomly generated authentication key is stored in the tsem_task
+structure of the process and propagated to any subsequent processes
+that are created in the namespace.  The hash product of this key and
+the orchestration authentication key, ie. the globally unique key, is
+placed in the tsem_task control structure of the orchestration
+process.
+
+When a control plane request is received, the authentication key
+provided by the trust orchestrator is used to re-generate an
+authentication key based on the randomly generated namespace key held
+by the process whose trust status is being updated and compared to the
+key in the tsem_task structure of the processing issuing the
+orchestration call.  The control plane will refuse to honor a control
+plane request if the call specific key does not match the key that was
+generated at the time the security namespace was created.
+
+Explicit vs generic modeling
+----------------------------
+
+In addition to the COE characteristics, TMA's have the ability to
+include the parameters that characterize the CELL of the security
+event into the generation of the security state coefficient for the
+event.  The inclusion of specific CELL characteristics is considered
+explicit modeling of the event.
+
+TMA's also have the ability to consider only the COE characteristics
+and the type of the event.  This is referred to as generic modeling of
+the event.
+
+In the current Linux TSEM implementation, the security event handlers
+differentiate, primarily due to current numerical resolution
+requirements of the models being implemented, some events to be
+generically modeled.  For these events, in addition to the COE
+characteristics and task identity, a default event specific CELL value
+is used in the computation of the security state coefficient.
+
+As was noted in the section on 'internal vs external modeling', the
+most common violation of trust is the initial execution of a binary or
+access to a file.  The inclusion of events, as generically modeled,
+allows the capture of security behaviors that are inconsistent with a
+proscribed security model, even if full characterization of the event
+is not implemented.
+
+As a further example.  If security workload unit testing has not
+included the ability of the workload to issue a request for creating
+and installing a BPF program, the mere request to do so is considered
+sufficient to place the workload in an untrusted state.
+
+In the following ABI document:
+
+Documentation/ABI/testing/tsemfs
+
+Documentation for the following control plane interface:
+
+/sys/kernel/security/tsem/InternalTMA/model0/trajectory
+
+Documents the security event parameters that are available for
+modeling by both internally and externally modeled namespaces.
+
+Event modeling
+--------------
+
+The generation of security state coefficients is a functional process
+that uses a cryptographic hash function for the creation of the
+various identity coefficient that make up the expression of the
+security state coefficient.
+
+TSEM can use any cryptographic hash function available to the Linux
+kernel for this purpose.  The hash function to be used for a security
+modeling namespace is specified as a parameter to the namespace
+creation process.
+
+By default, the root security namespace uses SHA256.  This value can
+be modified through the tsem_digest kernel command-line parameter.
+
+Since TSEM is active before the kernel has the ability to load
+modules, the root modeling domain must be a cryptographic hash
+function that is statically compiled into the kernel.  By default the
+TSEM configuration selects for the presence of the SHA256 hash
+function.
+
+TSEM security event modeling is based on the following functional
+definition for a security event coefficient:
+
+Coeff = HF(HF(EVENT_ID) || TASK_ID || HF(COE) || HF(CELL))
+
+	Where:
+		Coeff	 = A security state coefficient that is equal
+			   in length to the digest value of the
+			   cryptographic hash function in use for the
+			   modeling namespace.
+
+		||       = Concatenation operator.
+
+		HF	 = Security namespace specific hash function.
+
+		EVENT_ID = ASCII name of event.
+
+		TASK_ID  = The process specific identity of the
+			   executable code that is initiating modeling
+			   of the security event.
+
+		COE      = Characteristics of the context of execution
+			   of the event.
+
+		CELL	 = Characteristics of the event that is being
+			   modeled.
+
+Workload or platform specific security state coefficient definitions
+are generated by a TMA, using whatever COE or CELL characteristics
+that are considered relevant for the model being implemented, to
+determine whether or not an event should lead to the process being
+considered trusted or untrusted.
+
+The TASK_ID component of the function above is important with respect
+to the generation of the security state coefficients.  The notion of a
+task identity serves to link the concepts of system integrity and
+security access control
+
+The TASK_ID is defined by the following function:
+
+TASK_ID = HF(HF(EVENT) || NULL_ID || HF(COE) || HF(CELL))
+
+	Where:
+		TASK_ID	  = The executable identity of the process
+			    expressed as a digest value of length
+			    equal to the cryptographic hash function
+			    the modeling namespace is using.
+
+		||        = Concatenation operator.
+
+		EVENT	  = The string "bprm_set_creds".
+
+		NULL_ID	  = A buffer a set of null bytes equal to the
+			    digest size of the hash function being
+			    used for the namespace.
+
+		COE	  = Characteristics of the context of execution
+			    calling the bprm_creds_for_exec LSM hook.
+
+		CELL	  = The characteristics of the file provided
+			    by the linux_binprm structure passed to
+			    the security bprm_set_creds handler.
+
+An informed reader will quickly conclude, correctly, that the TASK_ID
+function generates an executable specific security coefficient for the
+bprm_creds_for_exec security hook.  The function is the same as the
+standard security state coefficient; with the exception that the task
+identity is replaced with a 'null id', consisting of the number of
+null bytes in the digest size of the namespace specific hash function.
+
+One of the CELL characteristics, used in the computation of the task
+identity, is the digest of the executable file.  Modifying an
+executable, or attempting to execute a binary not considered in the
+security model, will result in an alteration of the task identity that
+propagates to the generation of invalid state coefficients.
+
+The task identity is saved in the TSEM specific task structure and is
+used to compute the state coefficients for any security events that
+the task subsequently executes.  As noted in the previous paragraph,
+incorporating the TASK_ID into the computation of security state
+coefficients results in the security state coefficient values becoming
+specific to the corpus of executable code that initiated a process.
+This affords a very high degree of specificity with respect to the
+security models that can be implemented.
+
+As was demonstrated in the TBDHTTRAD section, TSEM will discriminate
+the following commands as different events/coefficients in a security
+model:
+
+cat /etc/shadow
+
+grep something /etc/shadow
+
+while read input
+do
+	echo $input;
+done < /etc/shadow
+
+An important, and perhaps subtle issue to note, is how these events
+result in the change of process trust status.  In the first two cases,
+if access to the /etc/shadow file is not permitted by the operative
+security model, the cat and grep process will become untrusted.
+
+In the third example, the shell process itself would become untrusted.
+This would cause any subsequent attempts to execute a binary to be
+considered untrusted events, even if access to the binary is a
+permitted coefficient in the model.
+
+Since the modeling operates at the level of a mandatory security
+control, these permission denials would occur even if the process is
+running with root privilege levels.  This is secondary to the notion
+that security and trust status are invested in the trust orchestrator
+and ultimately the TMA.
+
+From a hardware perspective, this is important with respect to the
+notion of a TMA being a model for a successor to the TPM.  From a
+system trust or integrity perspective, a TPM is designed to provide a
+retrospective assessment of the actions that have occurred on a
+platform.  A verifying party uses the TPM event log and a PCR based
+summary measurement, to verify what actions have occurred on the host,
+in order to allow a determination of whether or not the platform
+should be 'trusted'.
+
+In contrast, a TSEM/TMA based system enforces, on a real time basis,
+that a platform or workload remains in a trusted state.  Security
+relevant actions cannot be conducted unless the TMA authorizes the
+actions as being trusted.
+
+This is particularly important with respect to embedded systems.  A
+TPM based architecture would not prevent a system from having its
+trust status altered.  Maintaining the system in a trusted state would
+require attestation polling of the system, and presumably, executing
+actions if the platform has engaged in untrusted behavior.
+
+Conversely, a trust orchestrated software implementation enforces that
+a system or workload remain in a security/trust state that it's
+security model was unit tested to.
+
+Security model functional definitions
+-------------------------------------
+
+Previously, classic trusted system implementations supported the
+notion of the 'measurement' of the system.  The measurement is the
+value of a linear extension function of all the security relevant
+actions recorded by a trust measurement system such as IMA.
+
+In TPM based trust architectures, this measurement is maintained in a
+PCR.  A measurement value is submitted to the TPM that extends the
+current measurement using the following formula:
+
+MEASUREMENT = HASH(CURRENT || NEW)
+
+	Where:
+		MEASUREMENT = The new measurement value to be maintained
+			      in the register for the system.
+
+		||	    = Concatenation operator.
+
+		HASH	    = A cryptographic hash function supported
+			      by the TPM device.
+
+		CURRENT     = The current measurement value.
+
+		NEW	    = A new measurement value to be added to
+			      the current measurement.
+
+In TPM1 based systems, the HASH function was SHA1.  Due to well
+understood security concerns about the cryptographic vitality of this
+function, TPM2 based systems provide additional HASH functions with
+stronger integrity guarantees, most principally SHA related functions
+with longer digest values such as SHA256, SHA384 and SM3.
+
+The use of a cryptographic function produces a non-commutative sum
+that can be used to verify the integrity of a series of measurements.
+With respect to security modeling theory, this can be thought of as a
+'time-dependent' measurement of the system.  Stated more simply, the
+measurement value is sensitive to the order in which the measurements
+were made.
+
+In systems such as IMA, the measurement value reflects the sum of
+digest values of what are considered to be security critical entities,
+most principally, files that are accessed, based on various policies.
+
+In TSEM based TMA's, the measurement of a modeling namespace is the
+sum of the security state coefficients generated by the operative
+security model being enforced.  As previously noted, on systems with a
+TPM, the root modeling namespace measurement is maintained by default
+in PCR 11 or the PCR that was selected at kernel configuration time.
+
+The challenge associated with classic integrity measurements is the
+time dependent nature of using a non-commutative summing function.
+The almost universal embrace of SMP based hardware architectures, in
+addition to standard kernel task scheduling issues, makes the
+measurement values non-deterministic.  This requires a verifying party
+to evaluate an event log, verified by a measurement value, to
+determine whether or not the system is in a security appropriate
+state.
+
+TSEM addresses this issue by implementing a strategy designed to
+produce a single functional value that represents the security state
+of a model.  This allows a TMA to attest to the trust/security status
+of a platform or workload by signing this singular value and
+presenting it to a verifying party.
+
+In TSEM nomenclature, this singular value is referred to as the
+'state' of the model.  The attestation model is to use trust
+orchestrators to generate the state value of a workload by unit
+testing.  This state value can be packaged with a utility or container
+to represent a summary trust characteristic that can be attested by a
+TMA, eliminating the need for a verifying partner to review and verify
+an event log.
+
+TMA's implement this architecture by maintaining a single instance
+vector of the set of security state coefficients that have been
+generated.  A state measurement is generated by sorting the vector in
+big-endian hash format and then generating a standard measurement
+digest over this new vector.
+
+Any security event that generates an associated state coefficient that
+is not in the model will resulted in a perturbed state function value.
+That perturbed value would be interpreted by a verifying party as an
+indication of an untrusted system.
+
+Since the TMA maintains the security event descriptions in time
+ordered form, the option to provide a classic event log and
+measurement are preserved and available.  Extensive experience in the
+development of TSEM modeled systems has demonstrated the superiority
+of state value interpretation over classic measurement schemes.
+
+A TMA may choose to incorporate a 'base nonce' into a security model
+that it is implementing, this base nonce is designed to serve in a
+manner similar to an attestation nonce.  If used, the trust
+orchestrator is responsible for negotiating a random base nonce with a
+verifying party at the time of initialization of a modeling namespace
+and providing it to the TMA.
+
+The TMA uses the base nonce to extend each security event coefficient
+that is generated by the model.  This causes the state and measurement
+values of the model to become dependent on this base nonce, a process
+that can be used to defeat a replay attack against the security model.
+
+Control plane
+-------------
+
+Both primary functions of TSEM: security modeling namespace management
+and the internal TMA modeling implementation, are controlled by
+pseudo-files in the securityfs filesystem.  The following directory
+is the top level implementation directory for the TSEM control plane:
+
+/sys/kernel/security/tsem
+
+The following file documents, in detail, the interfaces provided by
+the filesystem:
+
+Documentation/ABI/testing/tsemfs
+
+This filesystem is primarily intended for use by trust orchestrators
+to create and manage security modeling namespaces.
+
+The files are process context sensitive.  Writing to the control file,
+or reading from the informational files, will act on or reference the
+security namespace that the accessing process is assigned to.
+
+The following files and directories are provided in the root directory
+of the TSEM control plane and implement global controls for the TSEM
+LSM:
+
+	id
+	control
+	aggregate
+
+The 'id' file is used to determine the modeling namespace that the
+process is running in.  The namespace id value of 0 is reserved for
+the root modeling namespace, a non-zero value indicates that the process
+is running in a subordinate modeling namespace.
+
+The TSEM implementation is controlled by the only writable file, which
+is the 'control' file.
+
+The following keywords are used by trust orchestrators to place the
+process writing to the file in an internally or externally modeled
+security namespace:
+
+	internal
+	external
+
+Each argument accepts key=value pairs that configure the namespace.
+The following key values are currently accepted:
+
+	nsref
+	digest
+	cache
+	key
+
+The 'nsref' keyword takes one of the following two values:
+
+	initial
+	current
+
+The initial argument indicates that the UID/GID values for the COE or
+the CELL characteristics are derived from the initial user namespace.
+This is the default characteristic if the nsref key is not specified.
+
+The current argument indicates that the UID/GID values are derived
+from the user namespace that the process is running in, when the
+request is made to model an event.
+
+The 'digest' keyword is used to specify the cryptographic hash
+function that is to be used to create the functional values for the
+security state coefficients for the namespace.  The value to this
+keyword is the name by which the hash function is defined by the
+cryptographic API in the kernel.
+
+Examples of suitable strings are as follows:
+
+	sha256
+	sha3-256
+	sm3
+
+Definitions for the names of the cryptographic hashes can be found in
+the source files for the various cryptographic hash functions in the
+'crypto' directory of the Linux source tree.
+
+The 'cache' keyword is used to specify the size of the caches used to
+hold pointers to data structures used for the modeling of security
+events or the export of the security event to external trust
+orchestrators.  These pre-allocated structures are used to service
+security event hooks that are called while the process is running in
+atomic context and thus cannot sleep or allocate memory.
+
+The argument to these keyword is a numeric value specifying the
+number of structures that are to be held in reserve for the namespace.
+
+By default the root modeling namespace and externally modeled
+namespaces have a default value of 96 entries.  An internally modeled
+namespace has a default value of 16 entries.
+
+The 'key' keyword is used to specify the authentication key that is to
+be used to support the authentication of trust control requests from a
+trust orchestrator to processes running in a security modeling
+namespace.  The argument to this keyword is the ASCII base16
+representation of the key that is to be used.  The length of the key
+must be equal to the size of the digest function defined for the
+namespace.
+
+The following keywords and arguments are used by trust orchestrators
+to set the trust status of a process after the processing of a
+security event by an external TMA:
+
+	trusted pid=PID key=HEXID
+	untrusted pid=PID key=HEXID
+
+	PID is the process identifier that is provided to the TMA in
+	the security event description.  HEXID is the base16 ASCII
+	representation of the authentication key that the security
+	modeling namespace was configured with when the namespace was
+	created.
+
+By default a modeling namespace runs in free modeling mode.  The modeling
+mode is changed by writing the following keywords to the control file:
+
+	seal
+	enforce
+
+The following keyword and argument are used to load a security model
+into an internal modeling namespace:
+
+	state value=HEXID
+
+	Where HEXID is the ASCII base 16 representation of a security
+	state coefficient that represents a valid security event in the
+	model.
+
+	After writing a series of state values the trust orchestrator
+	writes the 'seal' keyword to the control file to complete
+	creation of a security model.  Writing the 'enforce' keyword
+	to the control file will result in that model being enforced.
+
+	A security model for a namespace is loaded by writing the
+	valid security coefficients for a model file to the control
+	plane.  This will result in the 'trajectory' file having no
+	event descriptions for a sealed model, since the event
+	description vector is only populated when a new state
+	coefficient is added to the model.
+
+	Since the state state coefficients are generated with a
+	cryptographic hash function, the first pre-image resistance
+	characteristics of the function prevents a security model
+	description from disclosing information about the
+	characteristics of the workload.
+
+The following keyword and argument is used to set a base nonce for the
+internal TMA:
+
+	base value=HEXID
+
+	Where HEXID is the ASCII base 16 representation of a value
+	that each measurement is to be extended with before being
+	committed as a measurement value for the model.
+
+The following keyword and argument is used to create a file digest
+pseudonym for the internal TMA:
+
+	pseudonym value=HEXID
+
+	Where HEXID is the ASCII base 16 representation of a file
+	digest pseudonym that is to be maintained by the model.  See
+	the ABI documentation for how the argument to this verb is
+	generated.
+
+The 'aggregate' file is used by trust orchestrators for internally
+modeled namespaces to obtain the hardware measurement value for
+inclusion in a security model. A trust orchestrator for an externally
+modeled namespace can capture this value, since it is exported as the
+first event that occurs in a security modeling namespace.
+
+The following two directories are implemented in the top level TSEM
+control directory in order to support interfaces to internally and
+externally modeled namespaces:
+
+	ExternalTMA
+	InternalTMA
+
+The ExternalTMA directory holds a file, that is created when the
+request to create an externally model security namespace is made, and
+are named for the id number of the security modeling namespace.  The
+descriptions for security events that occur in the context of the
+namespace are exported in JSON format to the external trust
+orchestrator that is managing the namespace.
+
+The InternalTMA directory is a container directory that holds
+directories for the control of each internal TMA that is implemented
+in the kernel.
+
+There is currently only a single kernel based TMA that is managed
+through the following directory:
+
+/sys/kernel/security/tsem/InternalTMA/model0
+
+The following files are implemented for this model:
+
+	measurement
+	state
+
+	trajectory
+	trajectory_coefficients
+	trajectory_counts
+
+	forensics
+	forensics_coefficient
+	forensics_counts
+
+The 'measurement' file outputs the classic linear extension value of
+the security state coefficients that are generated in the context of
+the security modeling namespace.  This value is time dependent and can
+be used to verify the order of the security events that occurred in
+the model
+
+The 'state' file outputs a time independent functional value of
+security state of the modeling namespace.  This value and its
+generation and motivation are discussed in the 'Security model
+functional definitions' section of this document.
+
+The 'trajectory' file outputs the description of each security event
+recorded by the model in time dependent form.  The ABI documentation
+file contains a complete description of the output that is generated
+by this file and the 'forensics' file described below.
+
+The 'trajectory_coefficients' file outputs the set of security state
+coefficients in the model.  These coefficients are the values of the
+event descriptions that are output in the 'trajectory' file.
+
+The 'trajectory_counts" file outputs the number of times that each
+security state coefficient, output by the 'trajectory_coefficients'
+file, has been experienced in the security namespace.  This value can
+be used to verify that a security sensitive event has occurred or for
+statistical inference as to the anomaly status of the namespace.
+
+The 'forensics' file outputs the description of security events that
+have occurred when the namespace security model is running in a sealed
+state.  These events are useful for characterizing a security
+intrusion that has occurred or for refinement of a security model.
+
+The 'forensics_coefficients' file outputs the security state
+coefficients that are generated by the forensics events that have
+been captured by the model and available through the 'forensics' file.
+
+The 'forensics_counts" file outputs the number of times that each
+security state coefficient output by the 'forensics_coefficients' file
+has been experienced in the security namespace.  This value can can be
+used for statistical inference as to the anomaly status of the
+namespace.
+
+Trust orchestrators
+===================
+
+In security modeling, the need for a trust orchestrator is embodied in
+Heisenberg's reflections on quantum mechanical modeling.  A modeled
+system cannot model itself without affecting the functional value of
+the security model being implemented.  An external entity is needed to
+setup, configure and monitor the state of a modeled system, in a
+manner that does affect the state of the modeled system itself.
+
+After creating and configuring a security modeling namespace, the
+orchestrator is responsible for executing and monitoring a process
+that is run in the context of the namespace.  The trust orchestrator
+is also responsible for providing access to the status of the security
+model being implemented by the TMA.
+
+Trust orchestrators for externally modeled namespaces, have an
+associated TMA that is responsible for implementing the security model
+for a namespace.  The TMA represents the the root of trust for the
+modeled namespace.  The TMA advises the trust orchestrator as to what
+the trust status for a process should be set to, based on the modeling
+of the security event characteristics that are presented to it by the
+trust orchestrator.
+
+In a trust orchestration architecture, secondary to their integral
+role in maintaining the trust state of the system, the trust
+orchestrators are the highest value security asset running on the
+system.  In order to support this, the Linux TSEM implementation
+implements a new security capability, CAP_ML, only trust orchestrators
+are designed to run with this capability.
+
+The CAP_ML capability is defined as a capability that allows the
+ability of it's holder to use namespace creation and security modeling
+to define the trust status of a system.
+
+Trust orchestrators are designed to drop the CAP_ML capability before
+forking the process that will be responsible for launching a modeled
+workload.  This provides an architecture where the root of trust for
+the system can be predicated on a small body of well audited
+orchestration utilities, that can be linked to a hardware root of
+trust implemented by a TPM or a hardware based TMA.
+
+Quixote
+=======
+
+	"He is awkward, past his prime and engaged in a task beyond his
+	 capacities."
+				- Don Quixote's able mount Rocinante
+
+The Quixote Trust Orchestration System, released in concert with TSEM,
+is an implementation of a trust orchestration environment that
+embodies the characteristics described above.  It provides all off the
+basic functionality needed to build and run security architectures
+based on TSEM using either internal or external TMA implementations.
+
+It is anticipated that Quixote would not be the only such system to
+take advantage of TSEM.  Given the burgeoning capability set of
+systemd, it would be an architecturally valid concept to have systemd,
+or other system init equivalents, gain the ability to launch critical
+system services in security modeled environments.
+
+The source code for Quixote, and TSEM patches for some LTS kernels are
+available at the following URL:
+
+ftp://ftp.enjellic.com/pub/Quixote
+
+The build of Quixote is somewhat formidable, given that it spans the
+range from system programming though SGX programming and into embedded
+micro-controller systems.  In order to facilitate experimentation,
+binaries statically compiled against MUSL libc are provided that have
+virtually no system dependencies, other than a TSEM enabled kernel.
+
+Sample utilities
+----------------
+
+The Quixote TSEM implementation implements a separate trust
+orchestration utility for each TMA environment, nee Sancho partner,
+that is supported:
+
+quixote	     -> TMA run in the kernel for internally modeled namespaces.
+
+quixote-us   -> TMA run in a userspace process.
+
+quixote-xen  -> TMA run in a Xen based stub domain.
+
+quixote-sgx  -> TMA run in an SGX enclave.
+
+quixote-mcu* -> TMA run in a micro-controller implementation.
+
+* = See discussion below.
+
+Each utility runs in one of two modes: process or container
+
+In process mode, a shell process is run as the workload process in a
+modeling namespace.  This mode is selected with the -P command-line
+option.
+
+In container mode, the default, the OCI runc utility is run as the
+workload process, with a 'bundle' argument that specifies a directory
+that contains a JSON container definition for a directory hierarchy in
+the bundle directory.  The /var/lib/Quixote/Magazine directory
+contains the bundle directories.
+
+The -c command-line option selects container mode, the argument to the
+option specifies the bundle directory for the runc utility.
+
+In order to support the creation of security models, each utility
+supports the -o command-line option to specify that a security model
+description be output when the modeled workload terminates.  The model
+is written to the name of the file supplied via the command-line
+option.
+
+If the -t command-line option is also specified, the security
+execution trajectory, rather than a model consisting of security state
+coefficients, is written to the output file.  This trajectory
+represents the description of the security events that were modeled.
+This trajectory can be converted to security state coefficients with
+the generate-states utility that is also provided in the utilities
+package.
+
+The -m command-line option is used to specify a model that is to be
+loaded into the TMA and optionally enforced.  By default the security
+model output with the -o command-line option will place the TMA in a
+sealed modeling state.  Any security events that are non-compliant
+with the model will be registered as forensics events.
+
+Adding the -e command-line option, with the '-m FILENAME' option, will
+cause the loaded model to be enforced.  Any forensic events will cause
+a permission denial to be returned to the caller of a TSEM LSM hook
+implementation.
+
+The Quixote package also includes the quixote-console utility, for
+interrogating the model state of both external and internal TMA's.
+The following command-line options request output of the following
+characteristics of the model:
+
+-C -> The current execution trajectory coefficient counts.
+
+-E -> The log of denied events.
+
+-F -> The current forensics execution trajectory.
+
+-M -> A definition for the current security model.
+
+-P -> The current security state coefficients.
+
+-S -> The state value of the model.
+
+-T -> The current security execution trajectory.
+
+Executing the utility, without these arguments, will cause a
+command-line version of the utility to be presented that takes the
+following arguments:
+
+show trajectory
+
+show coefficients
+
+show counts
+
+show forensics
+
+show forensics_coefficients
+
+show forensics_counts
+
+show state
+
+show model
+
+quit
+
+It is important to note that any of the values output, represent the
+current state of the model and do not reflect a cumulative model of
+the workload.  Capturing a complete workload model requires the use of
+the -m command-line argument to the trust orchestrators to capture a
+model that is representative of the entire execution trajectory of the
+workload after it completes.
+
+As an example, the following security model definition represents the
+execution and termination of a shell session run on a system with a
+hardware TPM:
+
+aggregate de2b9c37eb1ceefa4bcbc6d8412920693d3272f30eb5ba98d51d2f898d620289
+state 97b29769580b412fbf55e326a98d6a1b97c6ebf446aaf78ea38c884e954ca5b2
+state 7c435854b4fa421175ec0a5d3ca7c156480913d85c03155ea3305afa56c9717d
+state 554d9f62693d522c9a43acf40780065f99cea3d67ca629ac4eaab4e22d4e63c2
+state 1b228046c4c2e7aa14db9a29fcff6f718f4f852afbfb76c8a45af7bf0485f9ce
+state 24fd04b10e2b5016e0061952f3bdea959e0fa80a55ff0f4e8e13f9f72ede7498
+state da6038511db71b08c49a838d178ed055e0b7bfc42548b4c2d71eca046e9a222e
+state 94b24ad4c8902f8ecb578a702408e8458e72c0774c402c3bd09ec5f390c4d0ae
+state 5ffa5a2a38f42d89ae74a6d58be8b687c1baed9746d9c6a7ae3c632a2e7c082f
+state a2e309d84bd4a52466c22779a622254c65ad1208583d70113751c4624baa7804
+state e93ceb0b1bf3cd58373a9e9ab4aca11a507782bbfde395ff68f8bfaf1678ed43
+state bf42388d63887368605fac9816134bc67314762c3a97b440cc48c5a30c07fdb9
+state eaa342599d682d63be4b64e159b98f21d85f0133ef5b28588e444ad12e446bf6
+state 2b9c86bc34202504c398c2f177d1dcf807b2f267c160bf8ebda863a9b427917f
+state 686fc3c958f2e4f2ce3b2c6a2cb3fff44ccc4db98869bd377b14e557a5191231
+state 613c39fd2a58413b32f448c13ea4d6bc38b77966dfc5560e39e4b37d2b2f5675
+state 70e276bfd7c20262cd9c9f5b09a922f11d16d1e3a602e8005d68e9ed6afc9b5d
+state 456aaedc5c1fc63f852ee97ae9561aba2a06c416154ecb9d7a1bf9d9a8c9c064
+state 97507c4c91af4a9b34b4d66118f6cc0ba1f8b55b8bb6e623dcafe27b100aea07
+state ea635c48031f81140b3561ed2291a3b1790a302e6adf5244320593b08a5af924
+state 2fd6a4d6ea1869a193926e998fbdf855916b510257d379762f48a1df63a810d4
+state 9c4cb7ef4848be1e29f9eb35fadaf5bfdc1fa3cbb22b6407cbd31b7088257026
+state 66640cbf9ae772515070f8613182b6852bf46220df0833fbe6b330a418fad95b
+state 6b0d1890cbd78c627e23d7a564e77a5ee88fb20e0662ce5e66f3727ebf75fa1d
+state bd28fa43b34850591fdf6fb2aa5542f33c21c20ee91b4bc2034e199b4e09edc1
+state 04425354419e53e6e73cde7d61856ff27763c2be01934e9990c1ae9f8d2a0b6e
+state 2650d86382f6404367b7fdeec07f873b67b9ce26caef09d035b4dff09fce04d5
+state df2f91f5fd84ca4621092420eaf1b0a3743b328a95e3f9e0b7b1281468462aa2
+state c730c66ecfabe99480e61a7f25962582ca7bb6f2b17983048e77adde1fe7f72b
+state 0fc937b71d0067fcc2c2f37c060763de250b3142e621174ffedc1b2520cdf6fd
+state 7f267400a3ccf462c77ae5129799558c2c62d8bc5b388882caec813ab4cf7b7f
+seal
+end
+
+As was previously discussed, the model should be cryptographically
+secure against the elucidation of the security events that resulted in
+the described security states.
+
+The Quixote userspace implementation also contains utilities for
+generating signed versions of these security models.
+
+* MCU TMA's
+-----------
+
+One of the objectives of TSEM/Quixote is to explore architectures for
+trusted systems that extend beyond what is provided by the TPM model
+for security co-processors.  The MCU based reference implementations
+allow experimentation with hardware based TMA's.
+
+The Quixote TSEM utilities include TMA implementations for the
+following following ARM32 based micro-controller platforms:
+
+STM32L496
+
+STM32L562
+
+NRF52840-DK
+
+NRF52840-DONGLE
+
+The STM32L496 platform, in addition to the base TMA implementation,
+includes support for a CAT1-M based cellular modem.  This demonstrates
+the ability of an external TMA to conduct remote, out-of-band,
+signaling of security violations for modeled platforms/workloads and
+the downloading of security models outside the context of the platform
+itself.
+
+The STM32L562 platform is a low power MCU designed for security
+focused IOT implementations.  It includes hardware hashing, hardware
+asymmetric encryption and Trust Zone support.
+
+Of primary interest may be the NRF52840-DONGLE implementation.  This
+is a 'USB fob' form factor board that GOOGLE uses as the basis for
+their OpenSK security key implementation.  This form factor allows the
+development and experimentation with easily deployable hardware based
+TMA implementations.
+
+The NRF52840-DONGLE architecture was chosen by the NLnet sponsored
+'FobNail' project, that is developing a hardware based attestation
+server:
+
+https://fobnail.3mdeb.com/
+
+The Fobnail projects discusses the notion of their architecture
+expanding to provide protection for a Linux system at large.
+Quixote/TSEM, running on the NRF52840-DONGLE micro-controller, is a
+demonstration of such an implementation.
+
+===============
+Closing Remarks
+===============
+
+	"Sometimes it is the people no one can imagine anything of who
+	 do the things no one can imagine.
+				- Alan Turing
+
+While this document is of some length and detail, it hopefully
+fulfills its obligation to provide sufficient prose for the
+justification of the security model that TSEM addresses, and in
+combination with trust orchestrators, implements.
+
+The MAINTAINERS file has contact information for feedback, patches
+and/or questions regarding TSEM and its reference TOS implementation.
+
+     The Quixote Team - Flailing at the Travails of Cybersecurity
+
+	With all due respect to Miguel de Cervantes Saavedra.
+
+   From the glacial moraine lake country of West-Central Minnesota.
+
+ LocalWords:  TSEM Brule Hilaire Belloc attestable namespace TOS TCB LSM LSM's
+ LocalWords:  filesystem metadata TBDHTTRAD tsem Continous workflow namespaces
+ LocalWords:  userspace quixote secundem artem inode boolean multi incent SEM
+ LocalWords:  analysing workflows COE TMA TPM orchestrators SGX Xen TMA's PCR's
+ LocalWords:  IMA PCR namesapces ie workqueue PID's PID OOM ABI SHA bprm creds
+ LocalWords:  linux binprm SMP endian tsemfs ExternalTMA HEXID pre Rocinante de
+ LocalWords:  systemd init LTS MUSL libc xen sgx mcu OCI runc JSON eb ceefa ba
+ LocalWords:  bcbc fbf ebf aaf ec afa acf cea eaab aa fcff afbfb af ce fd bdea
+ LocalWords:  ede da bfc eca ecb bd ae ffa baed ceb cd aca bbfde bfaf fac bc ef
+ LocalWords:  fdb eaa dcf ebda fc cb fff ccc dfc bfd afc aaedc ee aba bb dcafe
+ LocalWords:  aea adf fbdf df fadaf bfdc cbb cbd cbf fbe fb fdf edc cde fdeec
+ LocalWords:  caef dff fce eaf ecfabe adde fe fcc ffedc cdf ccf caec STM NRF DK
+ LocalWords:  IOT USB GOOGLE OpenSK deployable NLnet FobNail Fobnail Saavedra
+ LocalWords:  Cybersecurity hexadecimally BPF Coeff securityfs nsref UID GID sm
+ LocalWords:  API sha crypto InternalTMA HIDS pid FILENAME
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9e5bab29685f..0e6640a78936 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6468,6 +6468,24 @@
 			with CPUID.16h support and partial CPUID.15h support.
 			Format: <unsigned int>
 
+	tsem_mode=	[TSEM] Set the mode that the Trusted Security Event
+			Modeling LSM is to run in.
+			Format: 1
+			1 -- Disable root domain modeling.
+
+	tsem_cache=	[TSEM] Define the size of the caches used to hold
+			pointers to structures that will be used to model
+			security events occurring in the root modeling
+			namespace that are called in atomic context.
+			Format: <integer>
+			Default: 96
+
+	tsem_digest=	[TSEM] Define the cryptographic hash function that
+			will be used to create security event coefficients
+			for in the root modeling namespace.
+			Format: {name of the cryptographic hash function}
+			Default: sha256
+
 	tsx=		[X86] Control Transactional Synchronization
 			Extensions (TSX) feature in Intel processors that
 			support TSX control.
-- 
2.39.1

